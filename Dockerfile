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

RUN cd /build-harness && \
      make helm:install docs:deps

WORKDIR /build-harness

ENTRYPOINT ["/bin/bash"]

