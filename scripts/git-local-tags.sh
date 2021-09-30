#!/usr/bin/env bash

# TODO: poner current branch or default branch if not $3
# git describe
# git tag --sort=taggerdate | tail -1
# git describe --abbrev=0 --tags
# git describe --abbrev=0
# All branches withouth --branches="${1}"
git describe --tags "$( git rev-list --tags --branches="${1}" )" # All branches withouth --branches="${1}"
git tag | sort -Vr
