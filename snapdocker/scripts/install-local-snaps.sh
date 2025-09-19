#!/usr/bin/env bash

set -ex

DIR=$1

while IFS= read -r SNAP; do
  BASE_NAME="$(echo "${SNAP##*/}" | cut -d '_' -f 1)"
  mkdir -p /snap/"${BASE_NAME}"
  unsquashfs -d /snap/"${BASE_NAME}"/current "${SNAP}"
done < <(find "${DIR}" -maxdepth 1 -mindepth 1 -name '*.snap' -type f 2>/dev/null | sort)
