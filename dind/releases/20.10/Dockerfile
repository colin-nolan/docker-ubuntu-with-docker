# DO NOT MODIFY - this file has been generated automatically!
# The original has been changed using patches that can be found in ../patches
ARG BASE_IMAGE=colinnolan/ubuntu-with-docker:20.10

FROM ${BASE_IMAGE}

# Requirements taken from (legacy): https://github.com/jpetazzo/dind/blob/master/Dockerfile
RUN apt-get update && apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        lxc \
        iptables \
        wget \
    && rm -rf /var/lib/apt/lists/*

# TODO aufs-tools

# set up subuid/subgid so that "--userns-remap=default" works out-of-the-box
RUN set -eux; \
	addgroup --system dockremap; \
	adduser --system --ingroup dockremap dockremap; \
	echo 'dockremap:165536:65536' >> /etc/subuid; \
	echo 'dockremap:165536:65536' >> /etc/subgid

# https://github.com/docker/docker/tree/master/hack/dind
ENV DIND_COMMIT 42b1175eda071c0e9121e1d64345928384a93df1

RUN set -eux; \
	wget -O /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind"; \
	chmod +x /usr/local/bin/dind

COPY dockerd-entrypoint.sh /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375 2376

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
