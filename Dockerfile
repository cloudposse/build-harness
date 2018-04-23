FROM golang:1.9.2-alpine3.7

RUN apk update && \
    apk --update add \
      jq \
      git \
      make \
      curl \
      bash \
      grep

ADD ./ /build-harness/

ENV INSTALL_PATH /usr/local/bin

WORKDIR /build-harness

RUN make -s chamber/install helm/install helmfile/install template/deps

ENTRYPOINT ["/bin/bash"]

