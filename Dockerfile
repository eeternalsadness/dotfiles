ARG UBUNTU_VER="24.04"

FROM ubuntu:${UBUNTU_VER}

WORKDIR /root/

# common tools
RUN apt-get update && apt-get install -y git ca-certificates unzip curl wget fzf

# neovim prerequisites
RUN apt-get install -y ninja-build gettext cmake build-essential && \
  git clone --depth=1 https://github.com/neovim/neovim

# time zone
ARG TZ_AREA=Asia
ARG TZ_ZONE=Bangkok
RUN echo "tzdata tzdata/Areas select ${TZ_AREA}}" > /tmp/preseed.conf && \
    echo "tzdata tzdata/Zones/Asia select ${TZ_ZONE}}" >> /tmp/preseed.conf && \
    debconf-set-selections /tmp/preseed.cfg && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
    rm /tmp/preseed.conf

# git config
ENV GIT_USER_NAME="Bach Nguyen" GIT_EMAIL=69bnguyen@gmail.com GIT_CRED_CACHE_TIMEOUT=3600
RUN git config --global credential.helper 'cache --timeout $GIT_CRED_CACHE_TIMEOUT' && \
    git config --global user.name "${GIT_USER_NAME}" && \
    git config --global user.email "${GIT_EMAIL}" && \
    git config --global push.autoSetupRemote true && \
    git config --global safe.directory '*'

ENTRYPOINT [ "/bin/bash" ]
