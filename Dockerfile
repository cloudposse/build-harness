FROM golang:1.20.13-alpine3.18

LABEL maintainer="Cloud Posse <hello@cloudposse.com>"

LABEL "com.github.actions.name"="Build Harness"
LABEL "com.github.actions.description"="Run any build-harness make target"
LABEL "com.github.actions.icon"="tool"
LABEL "com.github.actions.color"="blue"

RUN apk --update --no-cache add \
      bash \
      build-base \
      ca-certificates \
      coreutils \
      curl \
      unzip \
      git \
      gettext \
      go \
      grep \
      groff \
      jq \
      libc6-compat \
      make \
      perl \
      python3-dev \
      py-pip \
      py3-ruamel.yaml \
      py3-cffi && \
    python3 -m pip install --upgrade pip setuptools wheel && \
    pip3 install --no-cache-dir \
      cryptography==41.0.7 \
      PyYAML==6.0.1 \
      awscli==1.32.23 \
      boto==2.49.0 \
      boto3==1.34.23 \
      iteration-utilities==0.12.0 \
      PyGithub==1.59.1 && \
    git config --global advice.detachedHead false

# Install pre-commit support
RUN pip install pre-commit
# Install ADR tools
RUN cd /usr/local/bin && curl -fsSL https://github.com/npryce/adr-tools/archive/refs/tags/3.0.0.tar.gz | \
    tar xzf - adr-tools-3.0.0/src --strip 2


### Workaround https://github.com/pypa/pip/issues/5247
# Should no longer be needed, but leaving it in case we need to revert
#RUN pip3 install --upgrade --force-reinstall pip==9.0.3 && \
#    pip3 install --no-cache-dir --disable-pip-version-check pre-commit && \
#    pip3 install --upgrade pip

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -fsSL --retry 3 https://apk.cloudposse.com/install.sh | bash

## Install as packages

## Codefresh required additional libraries for alpine
## So can not be curl binary
RUN apk --update --no-cache add \
      chamber@cloudposse \
      gomplate@cloudposse \
      helm@cloudposse \
      helmfile@cloudposse \
      codefresh@cloudposse \
      npm nodejs \
      terraform-0.11@cloudposse terraform-0.12@cloudposse \
      terraform-0.13@cloudposse terraform-0.14@cloudposse \
      terraform-0.15@cloudposse terraform-1@cloudposse \
      terraform-config-inspect@cloudposse \
      terraform-docs@cloudposse \
      vert@cloudposse \
      yq@cloudposse && \
    sed -i /PATH=/d /etc/profile

# Use Terraform 1 by default
ARG DEFAULT_TERRAFORM_VERSION=1
RUN update-alternatives --set terraform /usr/share/terraform/$DEFAULT_TERRAFORM_VERSION/bin/terraform

# Install tflint
RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

COPY <<EOF /root/.tflint.hcl
plugin "aws" {
    enabled = true
    version = "0.26.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
EOF

RUN tflint --init

# Patch for old Makefiles that expect a directory like x.x from the 0.x days.
# Fortunately, they only look for the current version, so we only need links
# for the current major version.
RUN v=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M '.current_version' | cut -d. -f1-2) && \
    major=${v%%\.*} && n=$(( ${v##*\.} + 1 )) && \
    for (( x=0; x <= $n; x++ )); do ln -s /usr/local/terraform/{${major},${major}.${x}}; done

COPY ./ /build-harness/

# Set PACKAGES_PREFER_HOST=true to prevent the build-harness from installing packages
# from the cloudposse/packages repository as part of the Docker image build process.
# Any needed packages should be installed in the Dockerfile above here instead.
ENV PACKAGES_PREFER_HOST=true

WORKDIR /build-harness

RUN make -s bash/lint make/lint
RUN make -s template/deps readme/deps
RUN make -s go/deps-dev

ENTRYPOINT ["/usr/bin/make"]
#ENTRYPOINT ["/bin/sh"]
