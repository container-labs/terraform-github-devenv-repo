# THIS IMAGE IS GENERATED, EDITS WILL BE OVERWRITTEN
ARG BASE_IMAGE=us-central1-docker.pkg.dev/containerlabs/gitpod/base:latest
FROM ${BASE_IMAGE}
ARG ELIXIR_VERSION=default

USER gitpod

RUN asdf plugin add elixir
RUN asdf install elixir ${ELIXIR_VERSION} && \
      asdf global elixir ${ELIXIR_VERSION}
