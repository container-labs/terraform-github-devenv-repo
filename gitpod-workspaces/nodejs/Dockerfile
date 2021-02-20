# THIS IMAGE IS GENERATED, EDITS WILL BE OVERWRITTEN
ARG BASE_IMAGE=us-central1-docker.pkg.dev/containerlabs/gitpod/base:latest
FROM ${BASE_IMAGE}
ARG NODEJS_VERSION=default

USER gitpod

RUN asdf plugin add nodejs
RUN asdf install nodejs ${NODEJS_VERSION} && \
      asdf global nodejs ${NODEJS_VERSION}
