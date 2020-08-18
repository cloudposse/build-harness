#!/usr/bin/env bash

function github_latest_release() {
  local org=$1
  local repo=$2
  local header=""
  
  if [ -n "$GITHUB_TOKEN" ] ; then
    header="Authorization: token $GITHUB_TOKEN"
  fi
  
  local ref=$(curl -sSL -H "$header" https://api.github.com/repos/$org/$repo/releases/latest | jq .tag_name -r)
  if [ $? -eq 0 ]; then
    echo $ref
  fi
}

function upgrade_modules() {
  local file=$1
  echo "Processing $file..."
  for source in $(grep -Po '^\s*source\s*=\s*"(.*?)"' -r .|cut -d'"' -f2|sort -u); do
    if [[ $source =~ github.com/ ]]; then
      echo "[GITHUB]: $source"
      if [[ $source =~ github.com/(.*?)/(.*?)\.git ]]; then
        org="${BASH_REMATCH[1]}"
        repo="${BASH_REMATCH[2]}"
      fi
      if [[ $source =~ \?ref=([0-9.]+) ]]; then
        ref="${BASH_REMATCH[1]}"
      fi
      if [[ $source =~ \?ref=tags/([0-9.]+) ]]; then
        ref="${BASH_REMATCH[1]}"
      fi

      if [ -z "$org" ] || [ -z "$repo" ] || [ -z "$ref" ]; then
        echo " - Failed to parse module source (org: $org, repo: $repo, ref: $ref)"
      else
        latest_ref=$(github_latest_release "$org" "$repo")
        latest_source="git::https://github.com/$org/$repo.git?ref=tags/$latest_ref"
        if [ "$latest_source" == "$source" ]; then
          echo " - Current: $ref"
        else
          echo " - Latest: $ref -> ${latest_ref}"
          echo " - Source: $latest_source"
          sed -i"" "s,$source,$latest_source,g" "$file"
        fi
      fi
    else
      echo "[SKIPPED]: $source"
    fi
  done
}

files=""
if [ $# -eq 0 ]; then
  echo "Usage: $0 [all|file1.tf...fileN.tf]"
  exit 1
elif [ $1 == "all" ]; then
  files=$(find . -type f -name '*.tf')
else
  files="$*"
fi

for file in $files; do
  upgrade_modules $file
done

