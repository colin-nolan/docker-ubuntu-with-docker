# DO NOT MODIFY - this file has been generated automatically!
# The original has been changed using patches that can be found in ../patches
ARG BASE_IMAGE=colinnolan/ubuntu-with-docker:18.04-19.03

FROM ${BASE_IMAGE}

# Requirements taken from (legacy): https://github.com/jpetazzo/dind/blob/master/Dockerfile
RUN apt-get update && apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        lxc \
        iptables \
    && rm -rf /var/lib/apt/lists/*

# TODO aufs-tools

# set up subuid/subgid so that "--userns-remap=default" works out-of-the-box
RUN set -x \
	&& addgroup --system dockremap \
	&& useradd --system -g dockremap -- dockremap \
	&& echo 'dockremap:165536:65536' >> /etc/subuid \
	&& echo 'dockremap:165536:65536' >> /etc/subgid

# https://github.com/docker/docker/tree/master/hack/dind
ENV DIND_COMMIT 37498f009d8bf25fbb6199e8ccd34bed84f2874b

RUN set -eux; \
	wget -O /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind"; \
	chmod +x /usr/local/bin/dind

COPY dockerd-entrypoint.sh /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375 2376

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
