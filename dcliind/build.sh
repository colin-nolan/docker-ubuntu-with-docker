#!/usr/bin/env bash
set -eu -o pipefail

scriptDirectory="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

buildTag="${1:-colinnolan/docker-with-ubuntu:latest}"

buildLocation=$("${scriptDirectory}/generate.sh")

docker build -t "${buildTag}" -f "${buildLocation}/Dockerfile" "${buildLocation}"

echo "${buildTag}"
