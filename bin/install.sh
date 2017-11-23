#!/bin/bash
export BUILD_MAKER_ORG=${1:-neildmorris}
export BUILD_MAKER_PROJECT=${2:-build-maker}
export BUILD_MAKER_BRANCH=${3:-master}
export GITHUB_REPO="https://github.com/${BUILD_MAKER_ORG}/${BUILD_MAKER_PROJECT}.git"

if [ "$BUILD_MAKER_PROJECT" ] && [ -d "$BUILD_MAKER_PROJECT" ]; then
  echo "Removing existing $BUILD_MAKER_PROJECT"
  rm -rf "$BUILD_MAKER_PROJECT"
fi

echo "Cloning ${GITHUB_REPO}#${BUILD_MAKER_BRANCH}..."
git clone -b $BUILD_MAKER_BRANCH $GITHUB_REPO
