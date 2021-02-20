# THIS IMAGE IS GENERATED, EDITS WILL BE OVERWRITTEN
ARG BASE_IMAGE=us-central1-docker.pkg.dev/containerlabs/gitpod/base:latest
FROM ${BASE_IMAGE}
ARG FLUTTER_VERSION=default

USER gitpod

RUN asdf plugin add flutter
RUN asdf install flutter ${FLUTTER_VERSION} && \
      asdf global flutter ${FLUTTER_VERSION}
