#!/usr/bin/env bash

set -eu -o pipefail

docker_version="$1"

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd)"
build_location="${script_directory}/build"
checkout_location="${build_location}/checkout"
release_location="${script_directory}/releases/${docker_version}"

rm -rf "${build_location}"

docker run --rm \
    -v "${script_directory}/patches:/mnt/host/patches:ro" \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    -v "${checkout_location}:/mnt/host/build-location" \
    colinnolan/patchworkdocker \
        prepare \
        --patch "/mnt/host/patches/Dockerfile.patch:${docker_version}/dind/Dockerfile" \
        --patch "/mnt/host/patches/dockerd-entrypoint.sh.patch:${docker_version}/dind/dockerd-entrypoint.sh" \
        --dockerfile "${docker_version}/dind/Dockerfile" \
        --build-location /mnt/host/build-location \
        https://github.com/docker-library/docker.git >&2

mkdir -p "${release_location}"
mv "${checkout_location}/${docker_version}/dind"/* "${release_location}/"
mv "${checkout_location}/LICENSE" "${release_location}"

rm -rf "${build_location}"

echo "${build_location}"
