# THIS IMAGE IS GENERATED, EDITS WILL BE OVERWRITTEN
ARG BASE_IMAGE=us-central1-docker.pkg.dev/containerlabs/gitpod/base:latest
FROM ${BASE_IMAGE}
ARG TERRAFORM_VERSION=default

USER gitpod

RUN asdf plugin add terraform
RUN asdf install terraform ${TERRAFORM_VERSION} && \
      asdf global terraform ${TERRAFORM_VERSION}
