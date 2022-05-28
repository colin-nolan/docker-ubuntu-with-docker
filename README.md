[![Docker Build Status](https://img.shields.io/docker/cloud/build/colinnolan/ubuntu-with-docker)](https://hub.docker.com/repository/docker/colinnolan/ubuntu-with-docker)
[![Docker Pulls](https://img.shields.io/docker/pulls/colinnolan/ubuntu-with-docker)](https://hub.docker.com/repository/docker/colinnolan/ubuntu-with-docker)

# Ubuntu-Based Docker-In-Docker
_Ubuntu-based versions of [Docker-In-Docker](https://hub.docker.com/_/docker) images_

If you don't need Ubuntu specifically, use the official images: https://hub.docker.com/_/docker


## Overview
There are two ways to use Docker inside of Docker:
1) Docker-CLI-In-Docker (dcliind): An image with the Docker CLI, in which the Docker socket from the host machine is 
   mounted and used.
2) Docker-In-Docker (dind): where the Docker daemon is installed and ran inside of a Docker image.

Both flavours are provided. The images are generated from the [official Docker images](https://hub.docker.com/_/docker),
which are based on Alpine. 

## Usage
### Docker-CLI-In-Docker (dcliind)
#### Run
```
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock:ro \
    colinnolan/ubuntu-with-docker:18.04-19.03
```

#### Build
Build the image for the `dcliind` directory of this repository with:
```
./build.sh
```
where the tag of the built image is given on stdout.

The following [build arguments](https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables---build-arg)
are available to customise the image:
  - `BASE_IMAGE`: base image to use (must be debian/ubuntu).
  - `DOCKER_CLI_DOWNLOAD_LOCATION`: location to download the Docker CLI binaries from (expected to be .tgz).
  - `DOCKER_CLI_DOWNLOAD_CHECKSUM`: checksum of downloaded .tgz file.


### Docker-In-Docker (dind)
#### Run
```
docker run -it --rm --privileged \
    colinnolan/ubuntu-with-docker:18.04-19.03-dind
```

#### Build
Build the image for the `dind` directory of this repository with:
```
./build.sh
```
where the tag of the built image is given on stdout.

The following [build arguments](https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables---build-arg)
are available to customise the image:
  - `BASE_IMAGE`: base image to use (must be debian/ubuntu based, with the Docker CLI installed).


## Legal
This work is in no way related to the company that I work for.
