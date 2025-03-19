FROM fedora:41

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
    && dnf clean all
