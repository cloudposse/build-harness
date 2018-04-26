FROM golang:1.9.2-alpine3.7

RUN apk update && \
    apk --update add \
      bash \
      ca-certificates \
      curl \
      git \
      gettext \
      grep \
      jq \
      make

ADD ./ /build-harness/

ENV INSTALL_PATH /usr/local/bin

WORKDIR /build-harness

ENV HELM_VERSION=2.9.0-rc5
RUN make -s chamber/install helm/install helmfile/install template/deps

ENTRYPOINT ["/bin/bash"]

