# THIS IMAGE IS GENERATED, EDITS WILL BE OVERWRITTEN
ARG BASE_IMAGE=us-central1-docker.pkg.dev/containerlabs/gitpod/base:latest
FROM ${BASE_IMAGE}
ARG ERLANG_VERSION=default

USER gitpod

RUN asdf plugin add erlang
RUN asdf install erlang ${ERLANG_VERSION} && \
      asdf global erlang ${ERLANG_VERSION}
