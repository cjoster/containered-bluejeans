#!/usr/bin/bash

set -xeuo pipefail

#BROWSER="google-chrome-stable --incognito"
BROWSER="google-chrome-stable"

sudo chown -R developer.developer /run/user/$(id -u developer)

[ -z "${@}" ] || exec $@

$BROWSER https://bluejeans.com &
BPID=$!
wait $BPID
