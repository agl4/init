FROM fedora:43
ARG BOOTSTRAP_BRANCH=main

ENV LC_ALL=C
ENV container=docker

COPY . /build

# Install dependencies
RUN touch /.dockerenv
RUN cd /build && bash -xv bootstrap.sh \
    && make pyenv-deps \
    && make nodenv-deps

# Cleanup
RUN rm -rf /build \
    && dnf clean all
