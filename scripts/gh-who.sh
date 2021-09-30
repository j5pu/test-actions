#!/usr/bin/env bash
# shellcheck disable=SC2089
# Who is logged in GitHub.

_prefix="${0%/.}"
_command="${_prefix##*git-}"
_HELP="
NAME
    gh-${_command} - Who is logged in GitHub?.

SYNOPSIS
    gh-${_command}
    gh ${_command}

DESCRIPTION
    Who is logged in GitHub.

OPTIONS
    -h, --help
        Show help.

EXAMPLES
    $ gh-${_command}; echo \$?

EXIT STATUS
  0   User logged in successfully.
  1   Work logged in successfully.
  2   Logged out"; export _HELP
_help "${@}" || exit 0

config_dir="${GH_CONFIG_DIR:-${XDG_CONFIG_HOME:-${HOME}/.config}/gh}"
token="$( yq e '.github*.oauth_token' "${config_dir}"/hosts.yml 2>/dev/null )"

if [[ "${token}" == "${GITHUB_USER_TOKEN}" ]]; then
  exit
elif [[ "${token}" == "${GITHUB_WORK_TOKEN}" ]]; then
  exit 1
else
  exit 2
fi
