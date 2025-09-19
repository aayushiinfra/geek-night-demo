#!/usr/bin/env bash
set -eo pipefail

DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

PLATFORM="arm64"

mkdir -p  /tmp/snap
pushd /tmp/snap



SNAPCRAFT_URL=$(curl -H 'X-Ubuntu-Series: 16' -H "X-Ubuntu-Architecture: $PLATFORM" 'https://api.snapcraft.io/api/v1/snaps/details/snapcraft?channel=6.x/stable'  | jq -r '.download_url')
curl --http1.1 -L $SNAPCRAFT_URL --output snapcraft.snap

mkdir -p /snap/snapcraft

unsquashfs -d /snap/snapcraft/current snapcraft.snap


#Python Interpreter

unlink /snap/snapcraft/current/usr/bin/python3
ln -s /snap/snapcraft/current/usr/bin/python3.* /snap/snapcraft/current/usr/bin/python3
echo /snap/snapcraft/current/lib/python3.*/site-packages >> /snap/snapcraft/current/usr/lib/python3/dist-packages/site-packages.pth


#Snap runner

mkdir -p /snap/bin
echo "#!/bin/bash" > /snap/bin/snapcraft
snap_version="$(awk '/^version:/{print $2}' /snap/snapcraft/current/meta/snap.yaml | tr -d \')" && echo "export SNAP_VERSION=\"$snap_version\"" >> /snap/bin/snapcraft
echo 'exec "$SNAP/usr/bin/python3" "$SNAP/bin/snapcraft" "$@" ' >> /snap/bin/snapcraft
chmod +x /snap/bin/snapcraft



popd
rm -rf /tmp/snap

