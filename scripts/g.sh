#!/usr/bin/env bash

: git

export _HELP="Run git command in repository directory.
Returns path (\$? 128 if not path) if not command.

Args:
  \$1 - optional: repo name, file or nothing for cwd.
  \$* - optional: any git command and arg.

Examples:
  $ # Path
  $ cd
  $ g; echo \$?
  128
  $ g test 2>/dev/null; echo \$?
  1
  $ g data
  .../data
  $ g data/README.md
  .../data
  $ cd ~/data; g
  .../data
  $
  $ # Aliases
  $ cd ~; g active
  fatal: not a git repository (or any of the parent directories): .git
  $ g data active
  main


  $ cd \"\${GIT}\"; g README.md active
  origin/main
  $ cd ..; g scripts active
  origin/main"

_h "${@}" || exit 0

(
  if [[ "${1-}" ]]; then
    if ! value="$( to-valid-value "${1}" )" && [ -f "${1}" ]; then  # repo env var with path.
      value="$( dirname "${1}" )"  # dir from file if not repo env var.
    fi
    if test -d "${value}" && git -C "${value}" rev-parse --show-toplevel >/dev/null 2>&1; then
      cd "${value}" || exit 1
      i=2  # removes $1
      if [[ "${1}" =~ ${_repo_git_cmd_diff_or} ]]; then warning "repo: ${1}" "in __git_cmds"; fi
    fi
  fi

  args=( "${@:${i:-1}}" )
  # TODO: test with commit -m "test message" to see if split words.
  # f() { args=( "${@:2}" ); printf '%s\n' "${args[@]}"; }; f a 'new message' b c
  # If problems instead of args=( "${@:1}" ) use printf '%s\n' "${args[@]}" or mapfile -t arr <<< ${rv} ?
  if [[ "${#args[@]}" -eq 0 ]]; then
    if [[ "${i-}" ]]; then pwd; else git -C "$( pwd )" rev-parse --show-toplevel 2>/dev/null; fi
#    elif [[ "${args[0]}" =~ ${__git_cmds_new_or} ]]; then
#      cmd="g_${args[0]//-/_}"
  elif [[ "${args[0]}" =~ ${__git_cmds_or} ]]; then
    git "${args[@]}"
  else
    error "g [$LINENO]:" "Invalid name/file or git command" "'$( printf '%s ' "${args[@]}" )'"; exit 1
  fi
)

debugend "${BASH_SOURCE[0]}"
