#!/usr/bin/env bash
dir="${0%/*}"
gall.sh
(
  cd "${dir}/.." || exit 1
  cwd="$( pwd )"
  test -f .pre-commit-config.yaml || pre-commit sample-config > .pre-commit-config.yaml
  pre-commit install --install-hooks
  pre-commit autoupdate
)
