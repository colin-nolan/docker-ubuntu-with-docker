#!/usr/bin/env bash
set -eu -o pipefail

scriptDirectory="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
buildLocation="${scriptDirectory}/build"
checkoutLocation="${buildLocation}/checkout"

rm -rf "${buildLocation}"

docker run --rm \
        -v "${scriptDirectory}/patches:/mnt/host/patches:ro" \
        -v /var/run/docker.sock:/var/run/docker.sock:ro \
        -v "${checkoutLocation}:/mnt/host/build-location" \
    colinnolan/patchworkdocker \
        prepare \
            --patch /mnt/host/patches/Dockerfile.patch:19.03/dind/Dockerfile \
            --patch /mnt/host/patches/dockerd-entrypoint.sh.patch:19.03/dind/dockerd-entrypoint.sh \
            --dockerfile 19.03/dind/Dockerfile \
            --build-location /mnt/host/build-location \
        https://github.com/docker-library/docker.git >&2

mv "${checkoutLocation}/19.03/dind"/* "${buildLocation}/"
mv "${checkoutLocation}/LICENSE" "${buildLocation}"
rm -rf "${buildLocation}/checkout"

echo "${buildLocation}"
