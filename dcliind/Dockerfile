ARG BASE_IMAGE=ubuntu:18.04

# Download Docker CLI binary
FROM alpine:3 as docker-download

RUN apk add --no-cache \
        bash \
        ca-certificates \
        curl \
        tar

SHELL ["bash", "-c"]

ARG DOCKER_CLI_DOWNLOAD_LOCATION=https://download.docker.com/linux/static/stable/x86_64/docker-19.03.5.tgz
ARG DOCKER_CLI_DOWNLOAD_CHECKSUM=1bb7a85fec2fea625bd0e46c04563523

RUN curl -L "${DOCKER_CLI_DOWNLOAD_LOCATION}" \
        | tee >(tar -xzvf - -C /opt 1>&2) \
        | md5sum -c <(echo "${DOCKER_CLI_DOWNLOAD_CHECKSUM}  -")


# Production image
FROM ${BASE_IMAGE}

# TODO: should we really be adding Python here...
RUN apt-get update && apt-get install --no-install-recommends -y \
         ca-certificates \
         python3 \
         python3-pip \
         python3-setuptools \
         wget \
    && rm -rf /var/lib/apt/lists/

COPY --from=docker-download /opt/docker /opt/docker/bin
ENV PATH="/opt/docker/bin:${PATH}"
