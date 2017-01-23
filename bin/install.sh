#!/bin/bash
export BUILD_HARNESS_PROJECT=${2:-build-harness}
export BUILD_HARNESS_BRANCH=${3:-master}
export GITHUB_REPO="https://github.com/cloudposse/${BUILD_HARNESS_PROJECT}.git"

if [ "$BUILD_HARNESS_PROJECT" ] && [ -d "$BUILD_HARNESS_PROJECT" ]; then
	echo "Removing existing $BUILD_HARNESS_PROJECT"
  rm -rf "$BUILD_HARNESS_PROJECT"
fi

git clone -b $BUILD_HARNESS_BRANCH $GITHUB_REPO
