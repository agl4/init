FROM debian:13.2
ARG BOOTSTRAP_BRANCH=main

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV container=docker

# https://blog.game-changing.de/how-to-set-timezone-and-locale-in-an-ubuntu-image-properly/
RUN apt-get update \
    && apt-get install -yq tzdata locales \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
    && locale-gen \
    && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && dpkg-reconfigure tzdata

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

COPY . /build

# Install dependencies
RUN touch /.dockerenv
RUN cd /build && bash -xv bootstrap.sh \
    && make nodenv-deps
# Cleanup
RUN rm -rf /build \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
