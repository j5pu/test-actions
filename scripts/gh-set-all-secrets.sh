#!/usr/bin/env bash
# shellcheck disable=SC1090
export GH_CONFIG_DIR="${HOME}/data/config/git"

for i; do
  case $i in
    --work)
      work=true
      gh logwork
      ;;
    --file=) file="${i#--file=}" ;;
    *) repo="--repo ${i}"
  esac
done

if [[ -z "${work}" ]]; then
  gh loguser
fi

file="${file:-${HOME}/data/config/.gitattributes}"
source "${file}"


while read -r var; do
  #  echo "repo: ${repo}, file: ${file}, work: ${work}, var: ${var}, value: ${!var}"
  # shellcheck disable=SC2086
  gh ${repo} secret set "${var//GITHUB_/}" -b"${!var}"  # Secret can not start with GITHUB_
done < <(grep "=" "${HOME}/data/config/.gitattributes" | awk '{print $2}' | awk -F "=" '{print $1}')
