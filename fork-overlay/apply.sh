#!/usr/bin/env bash

set -euo pipefail

# remove upstream's github workflows
find .github/workflows \
    -type f \
    ! -name build-image-on-release.yml \
    ! -name rebuild-fork.yml \
    -exec rm {} \;

# apply patches
git apply /tmp/fork-overlay/patches/*.patch

# copy files in
cp -a /tmp/fork-overlay/files/. .
