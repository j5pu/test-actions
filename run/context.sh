#!/usr/bin/env bash
(
  export GH_CONFIG_DIR="${HOME}/data/config/git"
  source "${HOME}/data/config/.gitattributes"
  gh loguser
  gh workflow run "context"
)
