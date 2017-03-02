#!/usr/bin/env bash

DOCKER_TAGS=("$TRAVIS_COMMIT")

echo "TRAVIS_BUILD_NUMBER=${TRAVIS_BUILD_NUMBER}"

if [ ! -z "${TRAVIS_TAG}" ]; then
  echo "TRAVIS_TAG=${TRAVIS_TAG}"
  DOCKER_TAGS+=("${TRAVIS_TAG}")
fi

if [ ! -z "${TRAVIS_PULL_REQUEST_BRANCH}" ]; then
  echo "TRAVIS_PULL_REQUEST_BRANCH=${TRAVIS_PULL_REQUEST_BRANCH}"
  DOCKER_TAGS+=("pr-${TRAVIS_PULL_REQUEST_BRANCH}")
  DOCKER_TAGS+=("pr-${TRAVIS_PULL_REQUEST_BRANCH}-${TRAVIS_BUILD_NUMBER}")
fi

if [[ -z "${TRAVIS_PULL_REQUEST_BRANCH}" && ! -z "${TRAVIS_BRANCH}" ]]; then
  echo "TRAVIS_BRANCH=${TRAVIS_BRANCH}"
  DOCKER_TAGS+=("${TRAVIS_BRANCH}")
  DOCKER_TAGS+=("${TRAVIS_BRANCH}-${TRAVIS_BUILD_NUMBER}")
fi

if [[ -z "${TRAVIS_TAG}"  &&  -z "${TRAVIS_PULL_REQUEST_BRANCH}"  &&  -z "${TRAVIS_BRANCH}" ]]; then
  DOCKER_TAGS+=("latest")
fi

if [[ -z "${TRAVIS_PULL_REQUEST_BRANCH}" ]]  && [[ "${TRAVIS_BRANCH}" == "master" ]]; then
  DOCKER_TAGS+=("latest")
fi

for TAG in "${DOCKER_TAGS[@]}"; do
  echo "Tagging ${DOCKER_IMAGE_NAME}:${TAG}"
  docker tag "${DOCKER_IMAGE_NAME}" "${DOCKER_IMAGE_NAME}:${TAG}" && \
    docker push "${DOCKER_IMAGE_NAME}:${TAG}";
  if [ $? -ne 0 ]; then
    echo "Failed" 1>&2
    exit 1
  fi
done
