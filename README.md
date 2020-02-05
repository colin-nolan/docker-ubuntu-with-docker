![Docker Build Status](https://img.shields.io/docker/cloud/build/colinnolan/ubuntu-with-docker)
![Docker Pulls](https://img.shields.io/docker/pulls/colinnolan/ubuntu-with-docker)

# Docker with Ubuntu
_Docker image with Docker CLI and Python - created as Molecule Ansible testing platform _

## Building
Build the image for the root directory of this repository with:
```
docker build -t colinnolan/docker-with-ubuntu .
```

The following [build arguments](https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables---build-arg)
are available to easily customise the image:
  - `BASE_IMAGE`: base image to use (must be debian/ubuntu).
  - `DOCKER_CLI_DOWNLOAD_LOCATION`: location to download the Docker CLI binaries from (expected to be .tgz).
  - `DOCKER_CLI_DOWNLOAD_CHECKSUM`: checksum of downloaded .tgz file.

## Usage
### Basic
```
docker run -it --rm \
        -v /var/run/docker.sock:/var/run/docker.sock:ro \
    colinnolan/ubuntu-with-docker
```

### In molecule.yml
```yaml
platforms:
  - name: instance
    image: colinnolan/ubuntu-with-docker
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
```
