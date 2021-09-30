#!/usr/bin/env bash
# shellcheck disable=SC2016
# https://gist.github.com/rponte/fdc0724dd984088606b0 local tags based on branch
# TODO: Faltaría todo lo de authentication al ser http o si es con ssh y releases.
# Sha256 hash of url
: '
repo="https://github.com/Checksum/critic.sh"
commit="$( git ls-remote "${repo}" HEAD | awk "{print \$1}" )" # get commit id
url="${repo}/archive/${commit}.tar.gz"

sha256
brew create --tap=j5pu/tools --set-name critic "${url}"


url="https://github.com/j5pu/fonts/archive/refs/tags/v0.1.0.tar.gz"
'

repo="https://github.com/${1}/${2}"
prefix="${repo}/archive"

if tag="$(git-latest-tag "${1}" "${2}")"; then
  echo "${prefix}/refs/tags/v${tag}.tar.gz"
elif commit="$(git-remote-commit-id "${1}" "${2}" "${3}")"; then
  echo "${repo}/${commit}.tar.gz"
fi
