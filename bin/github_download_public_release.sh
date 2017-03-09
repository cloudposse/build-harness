#!/usr/bin/env bash
#
# github_download_public_release.sh! It works!
#
# Source https://gist.github.com/maxim/6e15aa45ba010ab030c4
#
# This script downloads an asset from latest or specific Github release of a
# private repo. Feel free to extract more of the variables into command line
# parameters.
#
# PREREQUISITES
#
# curl, wget, jq
#
# USAGE
#
# Set all the variables inside the script, make sure you chmod +x it, then
# to download specific version to my_app.tar.gz:
#
#     github_download_public_release.sh 2.1.1 my_app.tar.gz
#
# to download latest version:
#
#     github_download_public_release.sh latest latest.tar.gz
#
# If your version/tag doesn't match, the script will exit with error.

#REPO="<user_or_org>/<repo_name>"
#FILE="<name_of_asset_file>"      # the name of your release asset file, e.g. build.tar.gz
VERSION=$1                       # tag name or the word "latest"
GITHUB="https://api.github.com"

alias errcho='>&2 echo'

function gh_curl() {
  curl -H "Accept: application/vnd.github.v3.raw" \
       $@
}

if [ "$VERSION" = "latest" ]; then
  # Github should return the latest release first.
  parser=".[0].assets | map(select(.name == \"$FILE\"))[0].id"
else
  parser=". | map(select(.tag_name == \"$VERSION\"))[0].assets | map(select(.name == \"$FILE\"))[0].id"
fi;

asset_id=`gh_curl -s $GITHUB/repos/$REPO/releases | jq "$parser"`
if [ "$asset_id" = "null" ]; then
  echo "ERROR: version not found $VERSION"
  exit 1
fi;

curl -H 'Accept:application/octet-stream' -o $2 -L  \
  https://api.github.com/repos/$REPO/releases/assets/$asset_id
