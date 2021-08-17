#!/usr/bin/env bash
source ./../.envgh auth login --hostname github.com --with-token <<< "${GITHUB_USER_TOKEN}"
gh workflow run commands
