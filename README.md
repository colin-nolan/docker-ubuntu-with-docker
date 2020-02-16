[![Docker Build Status](https://img.shields.io/docker/cloud/build/colinnolan/ubuntu-with-docker)](https://hub.docker.com/repository/docker/colinnolan/ubuntu-with-docker)
[![Docker Pulls](https://img.shields.io/docker/pulls/colinnolan/ubuntu-with-docker)](https://hub.docker.com/repository/docker/colinnolan/ubuntu-with-docker)

# Docker Image: Ubuntu with Docker
_Ubuntu-based versions of [Docker-In-Docker](https://hub.docker.com/_/docker) images_

## Overview
There are two ways to use Docker inside of Docker:
1) Docker-CLI-In-Docker (dcliind): An image with the Docker CLI, in which the Docker socket from the host machine is 
   mounted and used.
2) Docker-In-Docker (dind): where the Docker daemon is installed and ran inside of a Docker image.

## Usage
### Docker-CLI-In-Docker
#### Build
Build the image for the `dcliind` directory of this repository with:
```
docker build -t colinnolan/docker-with-ubuntu:docker .
```

The following [build arguments](https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables---build-arg)
are available to easily customise the image:
  - `BASE_IMAGE`: base image to use (must be debian/ubuntu).
  - `DOCKER_CLI_DOWNLOAD_LOCATION`: location to download the Docker CLI binaries from (expected to be .tgz).
  - `DOCKER_CLI_DOWNLOAD_CHECKSUM`: checksum of downloaded .tgz file.

#### Run
##### Basic
```
docker run -it --rm \
        -v /var/run/docker.sock:/var/run/docker.sock:ro \
    colinnolan/ubuntu-with-docker:docker
```

##### In `molecule.yml`
```yaml
platforms:
  - name: instance
    image: colinnolan/ubuntu-with-docker
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
```

### Docker-In-Docker
TODO