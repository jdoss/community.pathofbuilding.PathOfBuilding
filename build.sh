#!/bin/bash

set -e

if [[ -z ${1} ]]; then
  POB_DEV_SHA=$(curl -sL https://api.github.com/repos/PathOfBuildingCommunity/PathOfBuilding/git/trees/dev|jq -r .sha)
else
  POB_DEV_SHA=${1}
fi
echo "Building commit ${POB_DEV_SHA}..."

POB_TMP_YAML=$(mktemp -p ${PWD} --suffix .yml)
yq '(.modules| map(select(.name == "PathOfBuildingCommunity"))| .[].sources| map(select(.type == "git")).[].commit) = env(POB_DEV_SHA)' community.pathofbuilding.PathOfBuilding.yml > ${POB_TMP_YAML}

flatpak-builder build-dir --user --force-clean --install ${POB_TMP_YAML}
rm -f ${POB_TMP_YAML}
