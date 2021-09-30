#!/usr/bin/env bash
# shellcheck disable=SC2089

_prefix="${0%/.}"
_command="git ${_prefix##*git-}"
_HELP="Is 'git add' needed?.

Usage:
  ${_command}

Arguments:
  name     Variable name.

Options:
  --help   Show help.

Examples:
  $ ${_command} data; echo \$?
  DATA
  $ to-valid-name .test-var
  TEST_VAR

Exit Status:
  0   No 'git add' needed.
  1   'git add' needed."; export _HELP

_help "${@}" || exit 0

for i do
  case "$i" in
    --help) echo "${_HELP}" ;;
    --user=) user="${i#--user=}" ;;
    --repo=) repo="${i#--repo=}" ;;
    --branch=) branch="${i#--branch=}" ;;
  esac
done

git ls-remote "https://github.com/${user}/${repo}.git" "${branch:-HEAD}" | awk '{print $1}'
