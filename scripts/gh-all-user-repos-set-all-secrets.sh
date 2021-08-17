#!/usr/bin/env bash
dir="${0%/*}"
export GH_CONFIG_DIR="${HOME}/data/config/git"
file="${1:-${HOME}/data/config/.gitattributes}"
file="${file:+--file ${file}}"
(
  cd "${dir}/.." || exit 1
  scripts="$( pwd )/scripts"
  for i in $( "${scripts}"/gh-all-user-repos.sh ); do
    "${scripts}"/gh-set-all-secrets.sh "${file}" "${i}"
  done
)
