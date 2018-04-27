FROM golang:1.9.2-alpine3.7

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
      make

ADD ./ /build-harness/

ENV INSTALL_PATH /usr/local/bin

WORKDIR /build-harness

RUN make -s chamber/install helm/install helmfile/install template/deps

ENTRYPOINT ["/bin/bash"]

