#!/usr/bin/env bash

function fetch() {
  local org=$1
  local repo=$2
  local api=$3
  local path=$4
  local header=""

  if [ -n "$GITHUB_TOKEN" ] ; then
    header="Authorization: token $GITHUB_TOKEN"
  fi

  if [ "${api}" == "index" ]; then
    api=""
  else
    api="/${api}"
  fi

  local ref=$(curl -sSL -H "$header" "https://api.github.com/repos/$org/${repo}${api}" | jq -r "$path")
  if [ $? -eq 0 ]; then
    echo $ref
  fi
}

if [ $# -eq 4 ]; then
  fetch "${1}" "${2}" "${3}" "${4}"
else
  echo "Usage: $0 [org] [repo] [api] [jq path]"
  echo "  e.g. $0 cloudposse geodesic license .license.spdx_id"
  echo "       $0 cloudposse geodesic releases/latest .tag_name"
  echo "       $0 cloudposse geodesic '' .description"
  exit 1
fi

