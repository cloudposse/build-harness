<!-- markdownlint-disable -->
## Makefile Targets
```text
Available targets:

  bash/lint                           Lint all bash scripts
  checkov/install                     Install checkov
  checkov/run                         Static code security analysis
  clean                               Clean build-harness
  docker/build                        Build docker image
  docker/clean                        Cleanup docker.                     WARNING!!! IT WILL DELETE ALL UNUSED RESOURCES
  docker/clean/containers             Cleanup docker containers.          WARNING!!! IT WILL DELETE ALL UNUSED CONTAINERS
  docker/clean/images                 Cleanup docker images.              WARNING!!! IT WILL DELETE ALL UNUSED IMAGES
  docker/clean/images/all             Cleanup docker images all.          WARNING!!! IT WILL DELETE ALL IMAGES
  docker/clean/networks               Cleanup docker networks.            WARNING!!! IT WILL DELETE ALL UNUSED NETWORKS
  docker/clean/volumes                Cleanup docker volumes.             WARNING!!! IT WILL DELETE ALL UNUSED VOLUMES
  docker/image/promote/local          Promote $SOURCE_DOCKER_REGISTRY/$IMAGE_NAME:$SOURCE_VERSION to $TARGET_DOCKER_REGISTRY/$IMAGE_NAME:$TARGET_VERSION
  docker/image/promote/remote         Pull $SOURCE_DOCKER_REGISTRY/$IMAGE_NAME:$SOURCE_VERSION and promote to $TARGET_DOCKER_REGISTRY/$IMAGE_NAME:$TARGET_VERSION
  docker/image/push                   Push $TARGET_DOCKER_REGISTRY/$IMAGE_NAME:$TARGET_VERSION
  docker/login                        Login into docker hub
  docs/targets.md                     Update `docs/targets.md` from `make help`
  docs/terraform.md                   Update `docs/terraform.md` from `terraform-docs`
  flake8/install                      Install flake8
  git/export                          Export git vars
  github/init                         Initialize GitHub directory with default .github files
  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  init                                Init build-harness
  make/lint                           Lint all makefiles
  packages/delete                     Delete packages
  packages/install/%                  Install package (e.g. helm, helmfile, kubectl)
  packages/install                    Install packages
  packages/reinstall/%                Reinstall package (e.g. helm, helmfile, kubectl)
  packages/reinstall                  Reinstall packages
  packages/uninstall/%                Uninstall package (e.g. helm, helmfile, kubectl)
  readme                              Alias for readme/build
  readme/build                        Create README.md by building it from README.yaml
  readme/init                         Create basic minimalistic .README.md template file
  readme/lint                         Verify the `README.md` is up to date
  terraform/fmt                       Format Terraform
  terraform/install                   Install terraform
  terraform/lint                      Lint check Terraform
  terraform/validate                  Basic terraform sanity check
  tflint/install                      Install tflint
  tflint/run                          A Pluggable Terraform Linter
  tfsec/install                       Install tfsec
  tfsec/run                           Static code security analysis

```
<!-- markdownlint-restore -->
