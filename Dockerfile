FROM golang:1.14.4-alpine3.11
LABEL maintainer="Cloud Posse <hello@cloudposse.com>"

LABEL "com.github.actions.name"="Build Harness"
LABEL "com.github.actions.description"="Run any build-harness make target"
LABEL "com.github.actions.icon"="tool"
LABEL "com.github.actions.color"="blue"

RUN apk update && \
    apk --update add \
      bash \
      ca-certificates \
      coreutils \
      curl \
      git \
      gettext \
      grep \
      jq \
      libc6-compat \
      make \
      py-pip && \
    git config --global advice.detachedHead false

RUN curl -sSL https://apk.cloudposse.com/install.sh | bash

## Install as packages

## Codefresh required additional libraries for alpine
## So can not be curl binary
RUN apk --update --no-cache add \
      chamber@cloudposse \
      helm@cloudposse \
      helmfile@cloudposse \
      codefresh@cloudposse \
      yq@cloudposse && \
    sed -i /PATH=/d /etc/profile

ADD ./ /build-harness/

ENV INSTALL_PATH /usr/local/bin

WORKDIR /build-harness

RUN make -s bash/lint make/lint
RUN make -s template/deps aws/install terraform/install packages/install/terraform-docs readme/deps
RUN make -s go/deps-build go/deps-dev

ENTRYPOINT ["/usr/bin/make"]
