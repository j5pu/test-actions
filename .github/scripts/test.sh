#!/usr/bin/env bash
echo -e "@basename - \$0: \n ${0##*/}"
echo -e "@dirname - \$0: \n ${0%/*}"
echo -e "@pwd: \n $( pwd )"
