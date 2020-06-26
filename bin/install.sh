#!/bin/bash
set -e

export BUILD_HARNESS_ORG=${1:-cloudposse}
export BUILD_HARNESS_PROJECT=${2:-build-harness}
export BUILD_HARNESS_BRANCH=${3:-master}
export GITHUB_REPO="https://github.com/${BUILD_HARNESS_ORG}/${BUILD_HARNESS_PROJECT}.git"

echo "Installing ${BUILD_HARNESS_PROJECT}..."

if [ -z "$BUILD_HARNESS_BRANCH" ] || [ "$BUILD_HARNESS_BRANCH" == "master" ] ; then
  BUILD_HARNESS_BRANCH="$(git ls-remote --tags "$GITHUB_REPO" 2>/dev/null | cut -d/ -f3 | sort -rV | head -1)"
fi

echo "Selected ${GITHUB_REPO}@${BUILD_HARNESS_BRANCH}"

if [ "$BUILD_HARNESS_PROJECT" ] && [ -d "$BUILD_HARNESS_PROJECT" ]; then
  echo "Fetching..."
  cd $BUILD_HARNESS_PROJECT
  git fetch --depth=1 --no-tags origin "${BUILD_HARNESS_BRANCH}" 2>/dev/null
  git checkout FETCH_HEAD 2>/dev/null
else
  echo "Cloning..."
  git clone -b "${BUILD_HARNESS_BRANCH}" --depth=1 --no-tags "${GITHUB_REPO}" 2>/dev/null
fi

echo "Done."
