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
  gh workflow run "${name}"
)
EOF
    chmod +x ./run/"${name}".sh
  done
)
