#!/usr/bin/env bash
# shellcheck disable=SC2089

_prefix="${0%/.}"
_command="${_prefix##*git-}"
_HELP="
NAME
    git-${_command} - Git remote url.

SYNOPSIS
    git ${_command} [-h | --help] [--remote=<name>] [-v | --verbose]
    git ${_command} [-r=<name> | --remote=<name>]

DESCRIPTION
    Get git remote url (default: origin).

OPTIONS
    -h, --help
        Show help.

    -r=<name>, --remote=<name>
        Remote name  (default: origin).

EXAMPLES
    $ ${_command}; echo \$?
    DATA
    $ to-valid-name .test-var
    TEST_VAR

Exit Status:
  0   No 'git add' needed.
  1   'git add' needed."; export _HELP

_help "${@}" || exit 0

args () {
  for i do
    case "$i" in
      -h|--help) echo "${_HELP}" ;;
      -n=*) name="${i#-n=}" ;;
      --name=*) name="${i#--name=}" ;;
      -r=*) remote="${i#-r=}" ;;
      --remote=*) remote="${i#--remote=}" ;;
      -u=*) user="${i#-u=}" ;;
      --user=*) user="${i#--user=}" ;;
      -C)
        shift;
        if top="$( git-top "${i}" 2>/dev/null )"; then
          c_args=( "-C"  "${i}" )
          valid_git=true
        fi
        ;;
    esac
  done
}

args "${@}"
if [[ "${#c_args[@]}" -eq 2 ]]; then
  c=true
  if top="$( git-top "${c_args[1]}" 2>/dev/null )"; then
    c_args[1]="${top}"
  fi
elif [[ "${#c_args[@]}" -eq 1 ]]; then
  error "no dir, file or name given for -C"
fi

"$( printf '%s ' "${c_args[@]}")"
if url="$( git config --get remote."${remote:-origin}".url )"; then
  echo "${url}"
else
  false
fi
