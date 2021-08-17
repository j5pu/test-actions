#!/usr/bin/env bash
dir="${0%/*}"
export GH_CONFIG_DIR="${HOME}/data/config/git"
source "${HOME}/data/config/.gitattributes"
gh loguser

gh repo list --source --limit 100 --no-archived | grep '/' | awk '{print $1}'
#gh repo list --source --limit 100 --no-archived --json nameWithOwner --jq '.[]' | jq .nameWithOwner
