#!/bin/bash

CODEFRESH_CLI=${CODEFRESH_CLI:-codefresh}
LIMIT=${LIMIT:-1000}
STATUS=${STATUS:-running}
PIPELINES=${PIPELINES:-}


function is_not_next() {
	local id=$1
	local branch=$2
	local piplines_names=($PIPELINES)

	next_id=$(${CODEFRESH_CLI} get builds ${piplines_names[@]/#/--pipeline-name=} \
		--branch ${branch} \
		--status ${STATUS}\
		--limit ${LIMIT} \
		-o id | tac | head -1)

	echo "${next_id} == ${id}"

	if [ "${next_id}" = "${id}" ];
	then
		return 0
	else
		return 1
	fi
}


# Verify if there's more than 1 running builds, if so, wait for the first to finish
while [ $(is_not_next ${CF_BUILD_ID} ${CF_BRANCH}) -eq 1 ];
do
	echo "waiting;"
done

