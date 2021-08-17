#!/usr/bin/env bash
dir="${0%/*}"
gall.sh
(
  cd "${dir}/.." || exit 1
  cwd="$( pwd )"
  rm -f ./run/*.sh
  for i in ./.github/workflows/*.yml; do
    file="${i##*/}"
    name="${file%.*}"
    cat <<EOF >./run/"${name}".sh
#!/usr/bin/env bash
(
  export GH_CONFIG_DIR="\${HOME}/data/config/git"
  source "\${HOME}/data/config/.gitattributes"
  gh loguser
  gh workflow run "${name}".yml
#  gh run watch -i 1
  run_info="\$( gh run list --workflow=${name}.yml --limit 1 | grep -v '^STATUS' | grep workflow_dispatch )"
#  status="\$( echo "\${run_info}" | awk '{print \$1}' )"
#  rc="\$( echo "\${run_info}" | awk '{print \$2}' )"
  id="\$( echo "\${run_info}" | awk '{print \$7}' )"
  gh run watch "\${id}"
#  echo "status=\${status}, rc=\${rc} id=\${id}"
#  gh run view "\${id}"
#  open "https://github.com/j5pu/test-actions/actions/runs/\${id}"
)
EOF
    chmod +x ./run/"${name}".sh
  done
)
