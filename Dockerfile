FROM golang:1.9.2-alpine3.7

RUN apk update && \
    apk --update add \
      git \
      make \
      curl \
      bash \
      grep

ADD ./ /build-harness/

RUN make helm:install \
  	  docs:deps \
  	  

ENTRYPOINT ["/bin/bash"]

