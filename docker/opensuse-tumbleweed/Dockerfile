FROM opensuse/tumbleweed:latest

ENV LC_ALL=C
ENV container=docker

COPY . /build

# Install dependencies
RUN touch /.dockerenv
RUN cd /build && bash bootstrap.sh \
    && make base \
    && make pyenv-deps \
    && make nodenv-deps

RUN zypper --non-interactive clean && \
    rm -rf /var/cache/zypp /tmp/* /var/tmp/*
