#!/usr/bin/env bash

set -euf -o pipefail

docker_version="$1"
build_tag="${2:-colinnolan/ubuntu-with-docker:${docker_version}}"

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd)"

pushd "${script_directory}/releases/${docker_version}" > /dev/null
docker build -t "${build_tag}" .
popd > /dev/null

echo "${build_tag}"
