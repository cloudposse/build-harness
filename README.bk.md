# Cloud Posse Build Harness [![Build Status](https://travis-ci.org/cloudposse/build-harness.svg)](https://travis-ci.org/cloudposse/build-harness)

This `build-harness` is a collection of Makefiles to facilitate building Golang projects, Dockerfiles, Helm charts, and more. 

It's designed to work with CI/CD systems such as Travis CI, CircleCI and Jenkins.

It's 100% Open Source and licensed under [APACHE2](LICENSE).


## Usage

At the top of your `Makefile` add, the following...

```make
-include $(shell curl -sSL -o .build-harness "https://git.io/build-harness"; echo .build-harness)
```

This will download a `Makefile` called `.build-harness` and include it at run-time. We recommend adding the `.build-harness` file to your `.gitignore`.

This automatically exposes many new targets that you can leverage throughout your build & CI/CD process.

Run `make help` for a list of available targets.


## Makefile Targets

```bash
$ make help

Available targets:

  bash:lint                           Lint all bash scripts
  docker:build                        Build docker image
  docker:login                        Login into docker hub
  docs:copyright-add                  Add copyright headers to source code
  docs:toc-update                     Update table of contents in README.md
  geodesic:deploy                     Run a Jenkins Job to Deploy $(APP) with $(CANONICAL_TAG)
  git:aliases-update                  Update git aliases
  git:submodules-update               Update submodules
  github:download-private-release     Download release from github
  github:download-public-release      Download release from github
  go:build                            Build binary
  go:build-all                        Build binary for all platforms
  go:clean                            Clean compiled binary
  go:clean-all                        Clean compiled binary and dependency
  go:deps                             Install dependencies
  go:deps-build                       Install dependencies for build
  go:deps-dev                         Install development dependencies
  go:fmt                              Format code according to Golang convention
  go:install                          Install cli
  go:lint                             Lint code
  go:test                             Run tests
  go:vet                              Vet code
  helm:install                        Install helm
  helm:repo:add-current               Add helm remote dev repos
  helm:repo:add-remote                Add helm remote repos
  helm:repo:build                     Build repo
  helm:repo:clean                     Clean helm repo
  helm:repo:fix-perms                 Fix repo filesystem permissions
  helm:repo:info                      Show repo info
  helm:repo:lint                      Lint charts
  helm:serve:index                    Build index for serve helm charts
  help                                This help screen
  jenkins:run-job-with-tag            Run a Jenkins Job with $(TAG)
  make:lint                           Lint all makefiles
  terraform:get-modules               Ensure all modules can be fetched
  terraform:get-plugins               Ensure all plugins can be fetched
  terraform:lint                      Lint check Terraform
  terraform:validate                  Basic terraform sanity check
  travis:docker-login                 Login into docker hub
  travis:docker-tag-and-push          Tag & Push according Travis environment variables
```
