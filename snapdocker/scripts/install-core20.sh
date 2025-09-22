#!/usr/bin/env bash
set -eo pipefail

DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"


PLATFORM="arm64"

mkdir /tmp/snap
pushd /tmp/snap

# Grab the core20 snap (which snapcraft uses as a base) from the stable channel
# and unpack it in the proper place.
CORE20_URL=$(curl -H 'X-Ubuntu-Series: 16' -H "X-Ubuntu-Architecture: $PLATFORM" 'https://api.snapcraft.io/api/v1/snaps/details/core20' | jq '.download_url' -r)
curl --http2 -L $CORE20_URL --output core20.snap
mkdir -p /snap/core20
unsquashfs -d /snap/core20/current core20.snap

popd
rm -rf /tmp/snap
