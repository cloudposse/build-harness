#!/bin/bash
export BUILD_HARNESS_ORG=${1:-bitdefendermdr}
export BUILD_HARNESS_PROJECT=${2:-build-harness}
export BUILD_HARNESS_BRANCH=${3:-master}
export GITHUB_REPO="https://github.com/${BUILD_HARNESS_ORG}/${BUILD_HARNESS_PROJECT}"

if [ "${BUILD_HARNESS_PROJECT}" ] && [ -d "${BUILD_HARNESS_PROJECT}" ]; then
  echo "Removing existing ${BUILD_HARNESS_PROJECT}"
  rm -rf "${BUILD_HARNESS_PROJECT}"
fi

echo "Cloning ${GITHUB_REPO}#${BUILD_HARNESS_BRANCH}..."
fetch --log-level=error --repo="${GITHUB_REPO}" --branch="${BUILD_HARNESS_BRANCH}" "${BUILD_HARNESS_PROJECT}"
