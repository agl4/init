ARG  VERSION=41
FROM fedora:${VERSION}

ENV LC_ALL=C
ENV container=docker

COPY . /build

# Install dependencies
RUN touch /.dockerenv
RUN cd /build && bash bootstrap.sh
RUN cd /build && make base
RUN cd /build && make pyenv-deps
RUN cd /build && make nodenv-deps

# Cleanup
RUN rm -rf /build \
    && dnf clean all
