FROM golang:1.11-alpine3.7

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

RUN apk --update --no-cache add \
      chamber \
      helm \
      helmfile \
      codefresh

ADD ./ /build-harness/

ENV INSTALL_PATH /usr/local/bin

WORKDIR /build-harness

RUN make -s template/deps aws/install

ENTRYPOINT ["/bin/bash"]

