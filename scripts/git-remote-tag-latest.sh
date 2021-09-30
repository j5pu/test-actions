#!/usr/bin/env bash

git-remote-tags "${1}" "${2}" | head -n 1 2>/dev/null
