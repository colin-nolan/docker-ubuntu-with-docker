#!/usr/bin/env bash
set -eu -o pipefail

scriptDirectory="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

buildTag="${1:-colinnolan/ubuntu-with-docker:latest-dind}"

buildLocation=$("${scriptDirectory}/generate.sh")

docker build -t "${buildTag}" -f "${buildLocation}/Dockerfile" "${buildLocation}"

echo "${buildTag}"
