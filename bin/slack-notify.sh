#!/usr/bin/env bash

source ${SLACK_NOTIFIER_TEMPLATE}

echo "${ACTION}"
echo "${SLACK_COLOR}"
echo "${SLACK_COLOR_DESTROY}"

${SLACK_NOTIFIER}