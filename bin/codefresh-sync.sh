#!/usr/bin/env bash

## Messages templates
MESSAGE_SEPARATOR="$(printf -- '_%.0s' {1..80})";

MESSAGE_NO_CHANGES_REQUIRED=">>>>>>>> Processing ${PIPELINE} pipeline ... No changes required";

MESSAGE_CHANGES_REQUIRED=">>>>>>>> Processing ${PIPELINE} pipeline ... Changes found
${MESSAGE_SEPARATOR}
These changes will be applied if you run the same command with the environment variable APPLY=true
or
make codefresh/sync/apply REPOSITORIES=${REPOSITORY} ACCOUNTS=${ACCOUNT} PIPELINES=${PIPELINE}
${MESSAGE_SEPARATOR}";

MESSAGE_APPLING_CHANGES=">>>>>>>> Processing ${PIPELINE} pipeline... Changes applied
${MESSAGE_SEPARATOR}";

MESSAGE_REPO_FOUND=">>>>>>>> Processing ${REPOSITORY} repository... Repo found
${MESSAGE_SEPARATOR}";

MESSAGE_REPO_NOT_FOUND_CREATING=">>>>>>>> Processing ${REPOSITORY} repository... Repo not found... Creating new repo
${MESSAGE_SEPARATOR}";

MESSAGE_REPO_NOT_FOUND_SKIP=">>>>>>>> Processing ${REPOSITORY} repository... Repo not found... Set APPLY=true to create or use
make codefresh/sync/apply REPOSITORIES=${REPOSITORY} ACCOUNTS=${ACCOUNT} PIPELINES=${PIPELINE}
${MESSAGE_SEPARATOR}";

## Prepare temporary directory
TMP_DIR=./tmp
rm -rf ${TMP_DIR}
mkdir -p ${TMP_DIR}


## Pipelines file names
PIPELINE_CURRENT=${TMP_DIR}/current.yaml
PIPELINE_NEW=${TMP_DIR}/new.yaml
PIPELINE_TO_APPLY=${TMP_DIR}/apply.yaml

PIPELINE_MACK=${BUILD_HARNESS_PATH}/templates/codefresh.sync.mask.yaml
PIPELINE_FULLNAME=${REPOSITORY}/${PIPELINE}

## Check if codefresh repo exists
${CODEFRESH_CLI} get repo ${REPOSITORY} | grep 'no available resources' > /dev/null 2>&1
REPO_FOUND=$?

if [[ "${REPO_FOUND}" == "1" ]]; then
  echo "${MESSAGE_REPO_FOUND}"
else
  if [[ "${APPLY}" == "true" ]]; then
    echo "${MESSAGE_REPO_NOT_FOUND_CREATING}"
    ${CODEFRESH_CLI} add repo ${REPOSITORY} -c github
  else
    echo "${MESSAGE_REPO_NOT_FOUND_SKIP}"
  fi
fi

## Check if pipeline exists on codefresh
${CODEFRESH_CLI} get pipelines ${PIPELINE_FULLNAME} > /dev/null 2>&1
PIPELINE_IS_NEW=$?

## Generate pipeline from template
gomplate -f templates/${ACCOUNT}/${PIPELINE}.yaml -d repository=env:REPOSITORY -d pipeline=env:PIPELINE -o ${PIPELINE_NEW}

if [[ "${PIPELINE_IS_NEW}" == "1" ]]; then
  ## Current pipeline is empty
  touch ${PIPELINE_CURRENT}
  ## New pipeline can be applied without any changes
  cp  ${PIPELINE_NEW} ${PIPELINE_TO_APPLY}
else

  ## Get current pipeline
  ${CODEFRESH_CLI} get pipelines ${PIPELINE_FULLNAME} -o yaml > ${PIPELINE_CURRENT}

  ## Create a copy of pipelines to apply
  cp ${PIPELINE_NEW} ${PIPELINE_TO_APPLY}

  ## Compare masked pipelines to be indifferent to timestamps and ids
  yq m -x -i ${PIPELINE_CURRENT} ${PIPELINE_MACK}
  yq m -x -i ${PIPELINE_NEW} ${PIPELINE_MACK}
fi

## Get diff between current and new pipelines
CODEFRESH_SYNC_PIPELINE_DIFF=$(diff -u -s ${PIPELINE_CURRENT} ${PIPELINE_NEW})
CODEFRESH_SYNC_PIPELINE_DIFF_IS_EMPTY=$?

if [[ "${CODEFRESH_SYNC_PIPELINE_DIFF_IS_EMPTY}" == "0" ]]; then
	echo "${MESSAGE_NO_CHANGES_REQUIRED}"
else
	if [[ "${APPLY}" == "true" ]]; then
		if [[ "${PIPELINE_IS_NEW}" == "1" ]]; then
			## Create pipeline
			echo "Creating pipeline ${PIPELINE_TO_APPLY}"
			${CODEFRESH_CLI} create -f  ${PIPELINE_TO_APPLY}
		else
			## Update pipeline
			echo "Updating pipeline ${PIPELINE_TO_APPLY}"
			${CODEFRESH_CLI} replace -f ${PIPELINE_TO_APPLY}
		fi

		echo "${MESSAGE_APPLING_CHANGES}"
		echo "${CODEFRESH_SYNC_PIPELINE_DIFF}"
		echo "${MESSAGE_SEPARATOR}"
		echo "${MESSAGE_SEPARATOR}"
	else
		echo "${MESSAGE_CHANGES_REQUIRED}"
		echo "${CODEFRESH_SYNC_PIPELINE_DIFF}"
		echo "${MESSAGE_SEPARATOR}"
		echo "${MESSAGE_SEPARATOR}"
	fi
fi

## Cleanup tmp directory
rm -rf ${TMP_DIR}
