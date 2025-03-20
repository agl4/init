FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV LC_ALL=C
ENV container=docker

COPY . /build

# Install dependencies
RUN touch /.dockerenv
RUN cd /build && bash bootstrap.sh \
    && make base \
    && make pyenv-deps \
    && make nodenv-deps
# Cleanup
RUN rm -rf /build \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
