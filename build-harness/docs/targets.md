<!-- markdownlint-disable -->
## Makefile Targets
```text
Available targets:

  checkov/install                     Install checkov
  checkov/run                         Static code security analysis
  clean                               Clean build-harness
  docs/targets.md                     Update `docs/targets.md` from `make help`
  docs/terraform.md                   Update `docs/terraform.md` from `terraform-docs`
  flake8/install                      Install flake8
  git/export                          Export git vars
  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  init                                Init build-harness
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
  terraform/checkov                   Advanced security analysis with checkov
  terraform/fmt                       Format Terraform
  terraform/install                   Install terraform
  terraform/lint                      Lint check Terraform
  terraform/tflint                    Advanced linting with tflint
  terraform/tfsec                     Basic security analysis with tfsec
  terraform/validate                  Basic terraform sanity check
  tflint/install                      Install tflint
  tflint/run                          A Pluggable Terraform Linter
  tfsec/install                       Install tfsec
  tfsec/run                           Static code security analysis

```
<!-- markdownlint-restore -->
