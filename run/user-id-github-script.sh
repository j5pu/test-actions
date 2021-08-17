#!/usr/bin/env bash
(
  export GH_CONFIG_DIR="${HOME}/data/config/git"
  source "${HOME}/data/config/.gitattributes"
  gh loguser
  gh workflow run "user-id-github-script".yml
  gh run watch -i 1 2>/dev/null
#  run_info="$( gh run list --workflow=user-id-github-script.yml --limit 1 | grep -v '^STATUS' | grep workflow_dispatch )"
#  status="$( echo "${run_info}" | awk '{print $1}' )"
#  rc="$( echo "${run_info}" | awk '{print $2}' )"
#  id="$( echo "${run_info}" | awk '{print $7}' )"
#  echo "status=${status}, rc=${rc} id=${id}"
#  gh run view "${id}"
#  open "https://github.com/j5pu/test-actions/actions/runs/${id}"
)
