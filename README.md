# Build Maker [![Build Status](https://travis-ci.org/neildmorris/build-maker.svg)](https://travis-ci.org/neildmorris/build-maker)

This `build-maker` is a collection of Makefiles to facilitate building Jekyll, Terraform, and more. fored from [build-harness](https://github.com/cloudposse/build-harness)

It's designed to work with CI/CD systems such as Travis CI, and Jenkins.

It's 100% Open Source and licensed under [APACHE2](LICENSE). || Thank you [Cloudposse](https://github.com/cloudposse)!

## Usage

At the top of your `Makefile` add, the following...

```
-include $(shell curl -o .build-maker "https://raw.githubusercontent.com/neildmorris/build-maker/master/Makefile?ref=latest)
```

This will download a `Makefile` called `.build-maker` and include it at run-time. Add `.build-maker` and `.build-maker.d/*` to your .gitignore file

This automatically exposes many new targets that you can leverage throughout your build & CI/CD process.

create a file in your project root folder called `requirements.build-maker` and include a list of modules to be included in your project

---
NOTE: This is the reason for this fork vs using the original [build-hareness](https://github.com/cloudposse/build-harness).  In the original work make `init` downloaded a install.sh which cloned the repo.  I choose to build a requirements file where I can be more selective on which Makefile to include in my project.  I also consolidated a number of Makefile and updated the folder structure for my purpose.
---

Run `make help` for a list of available targets.

---
NOTE: `make help` uses comments in the Makefile to dynamically build the help.  This means if you run `make help` prior to `make init` the only target is `help`.  Once your modules have been downloaded those targets will also be available and will show up in `make help`
---

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
  jekyll:install                      Installs Jekyll
  jekyll:Serve                        Serve the Jekyll site locally @ 127.0.0.1:4000
  jekyll:newpost                      Create a new Jekyll post using vi
  jekyll:generate-tags                Generate tags
  jekyll:generate-categories          Generate categories
  jekyll:integrate-personal           Integrate personal
  jekyll:building                     Builds the Jekyll site for publication
  make:lint                           Lint all makefiles
  terraform:get-modules               Ensure all modules can be fetched
  terraform:get-plugins               Ensure all plugins can be fetched
  terraform:lint                      Lint check Terraform
  terraform:validate                  Basic terraform sanity check
  travis:docker-login                 Login into docker hub
  travis:docker-tag-and-push          Tag & Push according Travis environment variables
```

## Help

**Got a question?**

File a GitHub [issue](https://github.com/neildmorris/build-maker/issues), send me an [email](mailto:neil.daren.morris@gmail.com) or [neildmorris.com](https://neildmorris.com#contact).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/neildmorris/build-maker/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor to this fork and want to get involved in developing the `build-maker`, reach out via [email](mailto:neil.daren.morris@gmail.com) or on my [website](https://neildmorris.com#contact)

In general, PRs are welcome. Follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull request** so that we can review your changes

**NOTE:** Be sure to merge the latest from "upstream" before making a pull request!

## License

[APACHE 2.0](LICENSE)

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.

## About

build-maker is a fork of [build-harness](https://github.com/cloudposse/build-harness) maintained by [Neil D. Morris](https://neildmorris.com).

See my other projects on [GitHub]](https://github.com/neildmorris) or [My Website](https://neildmorris.com).

  [website]: http://neildmorris.com/
  [community]: https://github.com/neildmorris/
  [get in touch]: http://neildmorris.com/contact/

### Contributors

Thank you [cloudposse](https://github.com/cloudposse) for [build-hareness](https://github.com/cloudposse/build-harness)

[Erik Osterman](https://github.com/osterman/)
[Igor Rodionov](https://github.com/goruha/)
