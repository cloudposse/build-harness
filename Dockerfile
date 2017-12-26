FROM golang:1.9.2-alpine3.7

RUN apk update && \
    apk add \
      git \
      make \
      curl \
      bash

ADD ./ /build-harness/

ENTRYPOINT ["/bin/bash"]

