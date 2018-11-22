FROM golang:1.11-alpine3.7

ADD https://apk.cloudposse.com/install.sh /tmp/apk.cloudposse.sh

RUN chmod +x /tmp/apk.cloudposse.sh && /tmp/apk.cloudposse.sh

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
      py-pip \
      chamber \
      helm \
      helmfile \
      aws \
      codefresh && \
    git config --global advice.detachedHead false

ADD ./ /build-harness/

ENV INSTALL_PATH /usr/local/bin

WORKDIR /build-harness

RUN make -s template/deps

ENTRYPOINT ["/bin/bash"]

