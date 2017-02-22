# Cloud Posse Build Harness

This `build-harness` is a collection of Makefiles to facilitate building Golang projects, Dockerfiles, Helm charts, and more. 

It's designed to work with CI/CD systems such as Travis CI, CircleCI and Jenkins.

It's 100% Open Source and licensed under [APACHE2](LICENSE).


## Usage

At the top of your `Makefile` add, the following...

```make
$(shell curl --silent -O "https://raw.githubusercontent.com/cloudposse/build-harness/master/templates/Makefile.build-harness")
include Makefile.build-harness
```

This will expose many new targets that you can leverage throughout your build & CI/CD process.

Run `make help` for a available targets.


## Makefile Targets

```bash
$ make help

Available targets:

  bash:lint                           Lint all bash scripts
  docker:build                        Build docker image
  docker:login                        Login into docker hub
  docs:copyright-add                  Add copyright headers to source code
  docs:toc-update                     Update table of contents in README.md
  git:submodules-update               Update submodules
  github:download-release             Download release from github
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
  make:lint                           Lint all makefiles
  travis:docker-tag-and-push          Tag according travis envvars and push
```


## Real World Examples

- [`github-authorized-keys`](https://github.com/cloudposse/github-authorized-keys/) - A Golang project that leverages `docker:%`, `go:%`, `travis:%` targets
- [`charts`](https://github.com/cloudposse/charts/) - A collection of Helm Charts that leverages `docker:%` and `helm:%` targets
- [`bastion`](https://github.com/cloudposse/bastion/) - A docker image that leverages `docker:%` and `bash:lint` targets




