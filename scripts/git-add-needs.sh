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

test -z "$( git ls-files --others --exclude-standard )"
