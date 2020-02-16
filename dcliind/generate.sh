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
            --patch /mnt/host/patches/Dockerfile.patch:19.03/Dockerfile \
            --patch /mnt/host/patches/docker-entrypoint.sh.patch:19.03/docker-entrypoint.sh \
            --patch /mnt/host/patches/modprobe.sh.patch:19.03/modprobe.sh \
            --dockerfile 19.03/Dockerfile \
            --build-location /mnt/host/build-location \
        https://github.com/docker-library/docker.git >&2

mv "${checkoutLocation}"/19.03/{Dockerfile,modprobe.sh,docker-entrypoint.sh} "${buildLocation}/"
mv "${checkoutLocation}/LICENSE" "${buildLocation}"
rm -rf "${buildLocation}/checkout"

echo "${buildLocation}"
