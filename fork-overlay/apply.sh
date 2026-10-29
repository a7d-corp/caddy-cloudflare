#!/usr/bin/env bash

set -euo pipefail

# remove upstream's github workflows
find .github/workflows \
    -type f \
    ! -name build-image-on-release.yml \
    ! -name rebuild-fork.yml \
    -exec rm {} \;

# remove upstream's dependabot config
rm -f .github/dependabot.yml

# add extra modules to the xcaddy build
sed -i '/xcaddy build \\$/a\    --with github.com/greenpau/caddy-security \\' Dockerfile
grep -q -- '--with github.com/greenpau/caddy-security' Dockerfile || {
    echo "Failed to add caddy-security to Dockerfile" >&2
    exit 1
}

# copy files in
cp -a /tmp/fork-overlay/files/. .
