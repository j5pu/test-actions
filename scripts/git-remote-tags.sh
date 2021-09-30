#!/usr/bin/env bash
# TODO: Aqui usar mejor SSH
#  git ls-remote --tags "https://github.com/$1/$2.git" | sed -nE 's#.*refs/tags/(v?[0-9]+(\.[0-9]+)*)$#\1#p' | sort -fVr
#  curl -s GET "https://api.github.com/repos/$1/$2/tags" | jq -r '.[].name' | head -n1
#  curl -s GET "https://api.github.com/repos/$1/$2/tags"\?per_page\=1 | jq -r '.[].name'

#  git fetch --all --tags && git ls-remote --tags origin | awk -F '/' '{print $3}' | sort -Vr
git ls-remote --tags "https://github.com/$1/$2.git" "${3:-HEAD}" | awk -F '/' '{print $3}' | sort -Vr
