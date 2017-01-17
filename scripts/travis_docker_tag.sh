#!/usr/bin/env bash

DOCKER_TAGS=($TRAVIS_COMMIT)

if [ ! -z "$TRAVIS_TAG" ]; then
  DOCKER_TAGS+=($TRAVIS_TAG)
fi

if [ ! -z "$TRAVIS_PULL_REQUEST_BRANCH" ]; then
  DOCKER_TAGS+=(pr-$TRAVIS_PULL_REQUEST_BRANCH)
  DOCKER_TAGS+=(pr-$TRAVIS_PULL_REQUEST_BRANCH-$TRAVIS_BUILD_NUMBER)
fi

if [[ -z "$TRAVIS_PULL_REQUEST_BRANCH" && ! -z "$TRAVIS_BRANCH" ]]; then
  DOCKER_TAGS+=($TRAVIS_BRANCH)
  DOCKER_TAGS+=($TRAVIS_BRANCH-$TRAVIS_BUILD_NUMBER)
fi

if [[ -z "$TRAVIS_TAG"  &&  -z "$TRAVIS_PULL_REQUEST_BRANCH"  &&  -z "$TRAVIS_BRANCH" ]]; then
  DOCKER_TAGS+=(latest)
fi

if [[ -z "$TRAVIS_PULL_REQUEST_BRANCH" ]]  && [[ "$TRAVIS_BRANCH" == "master" ]]; then
  DOCKER_TAGS+=(latest)
fi


for TAG in "${DOCKER_TAGS[@]}"; do
  docker tag $DOCKER_IMAGE_NAME $TAG && docker push $TAG;
done
