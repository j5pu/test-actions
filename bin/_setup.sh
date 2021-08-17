#!/usr/bin/env bash
dir="${0%/*}"
gall.sh
(
  cd "${dir}/.." || exit 1
  cwd="$( pwd )"
  pre-commit sample-config
  pre-commit install --install-hooks
  pre-commit autoupdate
)
