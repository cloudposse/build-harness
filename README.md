

<!-- markdownlint-disable -->
<a href="https://cpco.io/homepage"><img src="https://github.com/cloudposse/build-harness/blob/master/.github/banner.png?raw=true" alt="Project Banner"/></a><br/>
    <p align="right">
<a href="https://github.com/cloudposse/build-harness/actions/workflows/docker.yml"><img src="https://img.shields.io/github/actions/workflow/status/cloudposse/build-harness/docker.yml?style=for-the-badge" alt="Build Status"/></a><a href="https://github.com/cloudposse/build-harness/releases/latest"><img src="https://img.shields.io/github/release/cloudposse/build-harness.svg?style=for-the-badge" alt="Latest Release"/></a><a href="https://github.com/cloudposse/build-harness/commits/master/"><img src="https://img.shields.io/github/last-commit/cloudposse/build-harness/master?style=for-the-badge" alt="Last Updated"/></a><a href="https://slack.cloudposse.com"><img src="https://slack.cloudposse.com/for-the-badge.svg" alt="Slack Community"/></a></p>
<!-- markdownlint-restore -->

<!--




  ** DO NOT EDIT THIS FILE
  **
  ** This file was automatically generated by the `cloudposse/build-harness`.
  ** 1) Make all changes to `README.yaml`
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file.
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **





-->

This `build-harness` is a collection of Makefiles to facilitate building READMEs, Golang projects, Dockerfiles, Helm charts, and more.
It's designed to work with CI/CD systems such as GitHub Actions.

## Screenshots

<img src="docs/demo.gif?raw=true" alt="demo" />*Example of using the `build-harness` to build a docker image*







## Usage


> [!IMPORTANT]
> **Regarding the phase out of `git.io`**
> Prior to April 25, 2022, practically all Cloud Posse Makefiles pulled in a common Makefile via
> ```bash
> curl -sSL -o .build-harness "https://git.io/build-harness"
> ```
> 
> The `git.io` service is a link shortener/redirector provided by GitHub, but [they no longer support it](https://github.blog/changelog/2022-04-25-git-io-deprecation/).
> We have therefore set up `https://cloudposse.tools/build-harness` as an alternative and are migrating
> all our Makefiles to use that URL instead. We encourage you to update any references you have in your
> own code derived from our code, whether by forking one of our repos or simply following one of our examples.
> 
> Full details are available in our [`git.io` deprecation documentation](docs/git-io-deprecation.md).

At the top of your `Makefile` add, the following...

```make
-include $(shell curl -sSL -o .build-harness "https://cloudposse.tools/build-harness"; echo .build-harness)
```

This will download a `Makefile` called `.build-harness` and include it at run time. We recommend adding the `.build-harness` file to your `.gitignore`.

This automatically exposes many new targets that you can leverage throughout your build & CI/CD process.

Run `make help` for a list of available targets.

**NOTE:** the `/` is interchangable with the `:` in target names

## GitHub Actions

The `build-harness` is compatible with [GitHub Actions](https://github.com/features/actions).

Here's an example of running `make readme/lint`

```yaml
name: build-harness/readme/lint
on: [pull_request]
jobs:
  build:
    name: 'Lint README.md'
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: cloudposse/build-harness@master
      with:
        entrypoint: /usr/bin/make
        args: readme/lint
 ```


## Quick Start

Here's how to get started...

1. `git clone https://github.com/cloudposse/build-harness.git` to pull down the repository
2. `make init` to initialize the [`build-harness`](https://github.com/cloudposse/build-harness/)
## Examples

Here is a real world example:
- [`terraform-null-label`](https://github.com/cloudposse/terraform-null-label/) - A terraform module that leverages `terraform/%` targets




<!-- markdownlint-disable -->
## Makefile Targets
```text
Available targets:

  aws/install                         Install aws cli bundle
  aws/shell                           Start a aws-vault shell with access to aws api
  bash/lint                           Lint all bash scripts
  chamber/install                     Install chamber
  chamber/shell                       Start a chamber shell with secrets exported to the environment
  clean                               Clean build-harness
  codefresh/export                    DEPRECATED!!! Export codefresh additional envvars
  codefresh/notify/slack/build        Send notification from codefresh to slack using "build" template
  codefresh/notify/slack/deploy       Send notification from codefresh to slack using "deploy" template
  codefresh/notify/slack/deploy/webapp Send notification from codefresh to slack using "deploy" template with exposed endpoint
  codefresh/notify/slack/sync         Send notification from codefresh to slack using "codefresh-sync" template
  codefresh/pipeline/export           Export pipeline vars
  codefresh/sync/apply                Codefresh pipelines sync - Apply the changes
  codefresh/sync/auth/%               Authentificate on codefresh account
  codefresh/sync/deps                 Install dependencies for codefresh sync
  codefresh/sync/diff                 Codefresh pipelines sync - Show changes
  codefresh/sync/pipeline/export      Export sync pipeline vars
  codefresh/trigger/webhook           Trigger a CodeFresh WebHook
  completion/install/bash             Install completion script for bash
  compose/build                       Build local dev environment
  compose/down                        Stop local dev environment
  compose/monitor                     Show containers resource usage
  compose/monitor/follow              Monitor in time containers resource usage
  compose/purge                       Purge local dev environment
  compose/rebuild                     Rebuild custom containers for local dev environment
  compose/restart                     Restart local dev environment
  compose/top                         Show top for containers
  compose/up                          Start local dev environment (daemonized)
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
  docs/copyright-add                  Add copyright headers to source code
  docs/github-action.md               Update `docs/github-action.md` from `action.yaml`
  docs/github-actions-reusable-workflows.md Update `docs/github-actions-reusable-workflows.md` from `.github/workflows/*.yaml`
  docs/targets.md                     Update `docs/targets.md` from `make help`
  docs/terraform.md                   Update `docs/terraform.md` from `terraform-docs`
  geodesic/deploy                     Run a Jenkins Job to Deploy $(APP) with $(CANONICAL_TAG)
  git/aliases-update                  Update git aliases
  git/export                          Export git vars
  git/submodules-update               Update submodules
  github/download-private-release     Download release from github
  github/download-public-release      Download release from github
  github/latest-release               Fetch the latest release tag from the GitHub API
  github/push-artifacts               Push all release artifacts to GitHub (Required: `GITHUB_TOKEN`)
  gitleaks/install                    Install gitleaks
  gitleaks/scan                       Scan current repository
  go/build                            Build binary
  go/build-all                        Build binary for all platforms
  go/clean                            Clean compiled binary
  go/clean-all                        Clean compiled binary and dependencies
  go/deps                             Install dependencies
  go/deps-dev                         Install development dependencies
  go/fmt                              Format code according to Golang convention
  go/install                          Install cli
  go/lint                             Lint code
  go/test                             Run tests
  go/vet                              Vet code
  helm/chart/build                    Build chart $CHART_NAME from $SOURCE_CHART_TPL
  helm/chart/build-all                Alias for helm/chart/build/all. Depricated.
  helm/chart/build/all                Build chart $CHART_NAME from $SOURCE_CHART_TPL for all available $SEMVERSIONS
  helm/chart/clean                    Clean chart packages
  helm/chart/create                   Create chart $CHART from starter scaffold
  helm/chart/promote/local            Promote $SOURCE_CHART_FILE to $TARGET_VERSION
  helm/chart/promote/remote           Promote $CHART_NAME from $SOURCE_VERSION to $TARGET_VERSION. ($SOURCE_CHART_REPO_ENDPOINT required)
  helm/chart/publish                  Alias for helm/chart/publish/all. WARNING: Eventually will became functional equal to helm/chart/publish/one
  helm/chart/publish/all              Publish chart $CHART_NAME to $TARGET_CHART_REPO_ENDPOINT
  helm/chart/publish/package          Publish chart $SOURCE_CHART_FILE to $REPO_GATEWAY_ENDPOINT
  helm/chart/starter/fetch            Fetch starter
  helm/chart/starter/remove           Remove starter
  helm/chart/starter/update           Update starter
  helm/delete/failed                  Delete all failed releases in a `NAMESPACE` subject to `FILTER`
  helm/delete/namespace               Delete all releases in a `NAMEPSACE` as well as the namespace
  helm/delete/namespace/empty         Delete `NAMESPACE` if there are no releases in it
  helm/install                        Install helm
  helm/repo/add                       Add $REPO_NAME from $REPO_ENDPOINT
  helm/repo/add-current               Add helm remote dev repos
  helm/repo/add-remote                Add helm remote repos
  helm/repo/build                     Build repo
  helm/repo/clean                     Clean helm repo
  helm/repo/fix-perms                 Fix repo filesystem permissions
  helm/repo/info                      Show repo info
  helm/repo/lint                      Lint charts
  helm/repo/update                    Update repo info
  helm/serve/index                    Build index for serve helm charts
  helm/toolbox/upsert                 Install or upgrade helm tiller 
  helmfile/install                    Install helmfile
  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  init                                Init build-harness
  jenkins/run-job-with-tag            Run a Jenkins Job with $(TAG)
  make/lint                           Lint all makefiles
  packages/delete                     Delete local copy of packages repository
  packages/install                    Download packages repository
  packages/install/%                  Install package (e.g. helm, helmfile, kubectl)
  packages/reinstall                  Reinstall local copy of packages repository
  packages/reinstall/%                Reinstall package (e.g. helm, helmfile, kubectl)
  packages/uninstall/%                Uninstall package (e.g. helm, helmfile, kubectl)
  readme                              Alias for readme/build
  readme/build                        Create README.md by building it from README.yaml
  readme/init                         Create basic minimalistic .README.md template file
  readme/lint                         Verify the `README.md` is up to date
  semver/export                       Export semver vars
  slack/notify                        Send webhook notification to slack
  slack/notify/build                  Send notification to slack using "build" template
  slack/notify/deploy                 Send notification to slack using "deploy" template
  template/build                      Create $OUT file by building it from $IN template file
  template/deps                       Install dependencies
  terraform/bump-tf-12-min-version    Rewrite versions.tf to bump modules with minimum core version of '0.12.x' to '>= 0.12.26'
  terraform/fmt                       Format terraform
  terraform/get-modules               (Obsolete) Ensure all modules can be fetched
  terraform/get-plugins               (Obsolete) Ensure all plugins can be fetched
  terraform/install                   Install terraform
  terraform/lint                      Format check terraform
  terraform/loosen-constraints        and convert "~>" constraints to ">=".
  terraform/precommit                 Terraform pull-request routine check/update
  terraform/rewrite-required-providers Rewrite versions.tf to update existing configuration to add an explicit source attribute for each provider
  terraform/tflint                    Lint terraform (with tflint)
  terraform/upgrade-modules           This target has not been upgraded to handle registry format
  terraform/validate                  Basic terraform sanity check
  travis/docker-login                 Login into docker hub
  travis/docker-tag-and-push          Tag & Push according Travis environment variables

```
<!-- markdownlint-restore -->
<!-- markdownlint-disable -->
## Extending `build-harness` with targets from another repo

It is possible to extend the `build-harness` with targets and entire modules of your own, without having to fork or modify `build-harness` itself.
This might be useful if, for example, you wanted to maintain some tooling that was specific to your environment that didn't have enough general applicability to be part of the main project.
This makes it so you don't necessarily need to fork `build-harness` itself - you can place a repo defined by the environment variable `BUILD_HARNESS_EXTENSIONS_PATH` (a filesystem peer of `build-harness` named `build-harness-extensions` by default) and populate it with tools in the same `Makefile` within `module` structure as `build-harness` has.
Modules will be combined and available with a unified `make` command. 
<!-- markdownlint-restore -->
<!-- markdownlint-disable -->
## Using the "auto-init" feature

Typically, the `build-harness` project requires running `make init` before any of the Makefile targets can be invoked. The `init` target will "install" the `build-harness` project and "include" the `Makefile` from the `build-harness` project.

Alternatively, the "auto-init" feature can automatically run the `init` logic for you to install the `build-harness` and help keep the install up-to-date. This feature is enabled using the env or Makefile variable `BUILD_HARNESS_AUTO_INIT=true`. By default, this feature is disabled; to enable it, you must set the variable yourself.

**Note:** The "auto-init" feature is a convenience for running `make` interactively. Regardless of your setting of `BUILD_HARNESS_AUTO_INIT`, "auto-init" will be disabled if `make` is running inside a Docker container. Scripts and automation should continue to call `make init` explicitly. 

```make
BUILD_HARNESS_AUTO_INIT = true

-include $(shell curl -sSL -o .build-harness "https://cloudposse.tools/build-harness"; echo .build-harness)
```

The "auto-init" feature will _also_ keep the install up-to-date. It will check the value of `BUILD_HARNESS_BRANCH`, get the commit ID, compare that to the current checkout, and update the clone if they differ. A useful side-effect is that it becomes easy to pin to versions of the `build-harness` from your own project, and let the `build-harness` update itself as you update the pin:

```make
BUILD_HARNESS_AUTO_INIT = true
BUILD_HARNESS_BRANCH = {TAG}

-include $(shell curl -sSL -o .build-harness "https://cloudposse.tools/build-harness"; echo .build-harness)
```

Now when you run `make` the project will update itself to use the version specified by the `BUILD_HARNESS_BRANCH` value:

```sh
$ make help
Removing existing build-harness
Cloning https://github.com/cloudposse/build-harness.git#{TAG}...
Cloning into 'build-harness'...
remote: Enumerating objects: 143, done.
remote: Counting objects: 100% (143/143), done.
remote: Compressing objects: 100% (118/118), done.
remote: Total 143 (delta 7), reused 71 (delta 3), pack-reused 0
Receiving objects: 100% (143/143), 85.57 KiB | 2.09 MiB/s, done.
Resolving deltas: 100% (7/7), done.
Available targets:

  aws/install                         Install aws cli bundle
```
<!-- markdownlint-restore -->


## Related Projects

Check out these related projects.

- [Packages](https://github.com/cloudposse/packages) - Cloud Posse installer and distribution of native apps
- [Atmos](https://github.com/cloudposse/atmos) - DevOps Automation Tool


## References

For additional context, refer to some of these links.

- [Wikipedia - Test Harness](https://en.wikipedia.org/wiki/Test_harness) - The `build-harness` is similar in concept to a "Test Harness"




## ✨ Contributing

This project is under active development, and we encourage contributions from our community.



Many thanks to our outstanding contributors:

<a href="https://github.com/cloudposse/build-harness/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudposse/build-harness&max=24" />
</a>

For 🐛 bug reports & feature requests, please use the [issue tracker](https://github.com/cloudposse/build-harness/issues).

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.
 1. Review our [Code of Conduct](https://github.com/cloudposse/build-harness/?tab=coc-ov-file#code-of-conduct) and [Contributor Guidelines](https://github.com/cloudposse/.github/blob/main/CONTRIBUTING.md).
 2. **Fork** the repo on GitHub
 3. **Clone** the project to your own machine
 4. **Commit** changes to your own branch
 5. **Push** your work back up to your fork
 6. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!

### 🌎 Slack Community

Join our [Open Source Community](https://cpco.io/slack?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/build-harness&utm_content=slack) on Slack. It's **FREE** for everyone! Our "SweetOps" community is where you get to talk with others who share a similar vision for how to rollout and manage infrastructure. This is the best place to talk shop, ask questions, solicit feedback, and work together as a community to build totally *sweet* infrastructure.

### 📰 Newsletter

Sign up for [our newsletter](https://cpco.io/newsletter?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/build-harness&utm_content=newsletter) and join 3,000+ DevOps engineers, CTOs, and founders who get insider access to the latest DevOps trends, so you can always stay in the know.
Dropped straight into your Inbox every week — and usually a 5-minute read.

### 📆 Office Hours <a href="https://cloudposse.com/office-hours?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/build-harness&utm_content=office_hours"><img src="https://img.cloudposse.com/fit-in/200x200/https://cloudposse.com/wp-content/uploads/2019/08/Powered-by-Zoom.png" align="right" /></a>

[Join us every Wednesday via Zoom](https://cloudposse.com/office-hours?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/build-harness&utm_content=office_hours) for your weekly dose of insider DevOps trends, AWS news and Terraform insights, all sourced from our SweetOps community, plus a _live Q&A_ that you can’t find anywhere else.
It's **FREE** for everyone!
## License

<a href="https://opensource.org/licenses/Apache-2.0"><img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg?style=for-the-badge" alt="License"></a>

<details>
<summary>Preamble to the Apache License, Version 2.0</summary>
<br/>
<br/>

Complete license is available in the [`LICENSE`](LICENSE) file.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```
</details>

## Trademarks

All other trademarks referenced herein are the property of their respective owners.


## Copyrights

Copyright © 2016-2024 [Cloud Posse, LLC](https://cloudposse.com)



<a href="https://cloudposse.com/readme/footer/link?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/build-harness&utm_content=readme_footer_link"><img alt="README footer" src="https://cloudposse.com/readme/footer/img"/></a>

<img alt="Beacon" width="0" src="https://ga-beacon.cloudposse.com/UA-76589703-4/cloudposse/build-harness?pixel&cs=github&cm=readme&an=build-harness"/>
