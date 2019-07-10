## Makefile Targets
```
Available targets:

  aws/install                         Install aws cli bundle
  aws/shell                           Start a aws-vault shell with access to aws api
  azure/clean                         Remove azure config files holding auth information
  azure/cleanrg                       Delete an Azure resource group and all it's content
  azure/init                          Initialize azure client and setup authentication
  azure/install                       Install Azure Command Line Client
  azure/venv-init                     Initialize pip virtual environment for azure cli
  bash/lint                           Lint all bash scripts
  chamber/install                     Install chamber
  chamber/shell                       Start a chamber shell with secrets exported to the environment
  cloudctl/cmd                        Execute $CLOUDCTL_COMMAND against $K8S_CLUSTER_MASTER_IP
  cloudctl/config                     Create cloudctl config for $K8S_CLUSTER_NAME
  cloudctl/install/cluster            Cloudctl install from a specific cluster
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
  deploy/aws                          Deploy icp on aws
  deploy/aws/clean                    Clean up all icp on aws deployment resources
  deploy/aws/destroy                  Destroy icp on aws deployment resources
  deploy/azure                        Deploy icp on azure
  deploy/azure/clean                  Clean up all icp on azure deployment resources
  deploy/azure/destroy                Destroy icp on azure deployment resources
  deploy/fyre                         Deploy on fyre
  deploy/fyre/clean                   Clean up all fyre deployment resources
  deploy/fyre/destroy                 Destroy fyre deployment resources
  deploy/fyre/install_fyre            Install Fyre plugin in the terraform plugin path = $(TERRAFORM_PLUGIN_PATH)
  deploy/nutanix                      Deploy on Nutanix
  deploy/nutanix/clean                Clean up all Nutanix deployment resources
  deploy/nutanix/destroy              Destroy Nutanix deployment resources
  deploy/openshift/aws                Deploy openshift on aws
  deploy/openshift/aws/clean          Clean up all openshift on aws deployment resources
  deploy/openshift/aws/destroy        Destroy openshift on aws deployment resources
  deploy/openshift4/aws               Deploy openshift on aws
  deploy/openshift4/aws/clean         Clean up all openshift on aws deployment resources
  deploy/openshift4/aws/destroy       Destroy openshift on aws deployment resources
  deploy/openstack                    Deploy on openstack
  deploy/openstack-kp                 Create a keypair for your host in OpenStack
  deploy/openstack-kp/destroy         Delete your host's keypair from OpenStack
  deploy/openstack/clean              Clean up all openstack deployment resources
  deploy/openstack/destroy            Destroy openstack deployment resources
  deploy/pentest                      Deploy pentest build
  deploy/pentest/clean                Clean up all pentest deployment resources
  deploy/pentest/destroy              Destroy pentest deployment resources
  deploy/powervc                      Deploy on PowerVC
  deploy/powervc/clean                Clean up all PowerVC deployment resources
  deploy/powervc/destroy              Destroy PowerVC deployment resources
  deploy/travis                       Deploy travis build (deploys on OpenStack in BlueRidgeGroup-Travis tenant)
  deploy/travis/clean                 Clean up all travis deployment resources
  deploy/travis/destroy               Destroy travis deployment resources
  deploy/vagrant                      Deploy ICP locally using vagrant
  deploy/vagrant/clean                Clean up all vagrant deployment resources
  deploy/vagrant/destroy              Destroy local ICP vagrant deployment
  deploy/vmw_cicdlab                  Deploy on vmw_cicdlab
  deploy/vmw_cicdlab/clean            Clean up all vmw_cicdlab deployment resources
  deploy/vmw_cicdlab/destroy          Destroy vmw_cicdlab deployment resources
  deploy/vsphere                      Deploy on vsphere
  deploy/vsphere/clean                Clean up all vsphere deployment resources
  deploy/vsphere/destroy              Destroy vsphere deployment resources
  deploy/z                            Deploy Z on openstack
  deploy/z/clean                      Clean up all Z openstack deployment resources
  deploy/z/destroy                    Destroy Z openstack deployment resources
  docker-ibm/attach                   Attach to the running container
  docker-ibm/build                    Build a docker image
  docker-ibm/clean                    Remove existing docker images
  docker-ibm/copy                     Copy docker image from one location to another (including multi-arch manifest list images)
  docker-ibm/export                   Export docker images to file
  docker-ibm/import                   Import docker images from file
  docker-ibm/info                     Display info about the docker environment
  docker-ibm/login                    Login to docker registry
  docker-ibm/manifest-tool            Download and install the manifest tool so you don't need the edge docker client
  docker-ibm/multi-arch               Push the manifest to a Docker registry
  docker-ibm/pull                     Pull docker image from Docker Hub
  docker-ibm/push                     Push image to Docker Hub
  docker-ibm/push-arch                Push the architecture-specific image to a Docker registry
  docker-ibm/run                      Test drive the image
  docker-ibm/shell                    Run the container and start a shell
  docker-ibm/tag                      Tag the last built image with an architecture-specific`DOCKER_TAG`
  docker-ibm/tag-arch                 Tag the last built image with `DOCKER_TAG`
  docker-ibm/test                     Test docker image
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
  geodesic/deploy                     Run a Jenkins Job to Deploy $(APP) with $(CANONICAL_TAG)
  git/aliases-update                  Update git aliases
  git/export                          Export git vars
  git/submodules-update               Update submodules
  git:aliases-update                  Update git aliases
  git:export                          Export git vars
  git:show                            Show vars
  git:submodules-update               Update submodules
  github/download-private-release     Download release from github
  github/download-public-release      Download release from github
  github/latest-release               Fetch the latest release tag from the GitHub API
  github/push-artifacts               Push all release artifacts to GitHub (Required: `GITHUB_TOKEN`)
  github/status/update_branch_protection Add status check to PRs for given branch in given repo
  github/status/update_status         Update the status of the given status check in the given repo for the given commit sha
  gitleaks/install                    Install gitleaks
  gitleaks/scan                       Scan current repository
  go-ibm/check                        Runs a set of required checks
  go-ibm/clean                        Remove generated build and test files
  go-ibm/copyright/check              Runs check to validate all files have the correct copyright header
  go-ibm/copyright/fix                Adds valid copyright header to .go files with invalid or missing header
  go-ibm/fmt                          Runs gofmt and applies changes across all go files
  go-ibm/imports                      Fix go imports in offending files, generally used after refactoring packages
  go-ibm/lint                         Runs a set of golang linting tools
  go-ibm/mocks                        Generate golang internal mock files
  go-ibm/ossc                         Generates new OPENSOURCE file
  go-ibm/ossc/check                   Runs check to validate OPENSOURCE file is up to date
  go-ibm/ossc/csv                     Generate OSSC csv file
  go-ibm/test                         Run all project tests
  go/build                            Build binary
  go/build-all                        Build binary for all platforms
  go/clean                            Clean compiled binary
  go/clean-all                        Clean compiled binary and dependency
  go/deps                             Install dependencies
  go/deps-build                       Install dependencies for build
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
  helm:cmd                            Execute $HELM_COMMAND
  helm:config                         Create helm config for $K8S_CLUSTER_NAME
  helm:copy                           Copy helm chart from one location to another
  helm:init                           Build index to serve helm charts
  helm:install                        Install helm
  helm:install:cluster                Install helm from the cluster at K8S_CLUSTER_CONSOLE_IP
  helm:tls-cmd                        Execute $HELM_COMMAND with --tls options
  helm:tunnel-down                    Tear down helm SSH tunnel, must be called after executing other targets
  helm:tunnel-up                      Bring up SSH tunnel for helm commands, must be called before executing any targets
  helmfile/install                    Install helmfile
  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  jenkins/run-job-with-tag            Run a Jenkins Job with $(TAG)
  make/lint                           Lint all makefiles
  packages/delete                     Delete packages
  packages/install                    Install packages 
  packages/install/%                  Install package (e.g. helm, helmfile, kubectl)
  packages/reinstall                  Reinstall packages
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
  ssh/keys                            Generate public/private ssh keys
  ssh/keys/clean                      Delete ssh key links in current directory
  ssh/keys/private                    Get the public key file used
  ssh/keys/public                     Get the public key file used
  template/build                      Create $OUT file by building it from $IN template file
  template/deps                       Install dependencies
  terraform/apply                     Run terraform apply with -var-file (TERRAFORM_VARS_FILE) in dir (TERRAFORM_DIR)
  terraform/check-ver                 Check for version of terraform required either from TERRAFORM_STATE_FILE or alternatively from TERRAFORM_VER
  terraform/delete-state              Delete terraform state from artifactory
  terraform/destroy                   Destroy terraform resources
  terraform/get-modules               Ensure all modules can be fetched
  terraform/get-modules-ibm           Ensure all modules can be fetched; export TERRAFORM_EXPORTS first
  terraform/get-plugins               Ensure all plugins can be fetched
  terraform/get-plugins-ibm           Ensure all plugins can be fetched; export TERRAFORM_EXPORTS first
  terraform/get-state                 Retrieve and untar terraform state from artifactory or emit error response
  terraform/install                   Install terraform
  terraform/install_ibm               Install terraform version required based on TERRAFORM_STATE_FILE or alternatively from TERRAFORM_VER
  terraform/lint                      Lint check Terraform
  terraform/output                    Print terraform output variable value
  terraform/save-state                Persist terraform state in artifactory
  terraform/upgrade-modules           Upgrade all terraform module sources
  terraform/validate                  Basic terraform sanity check
  terraform/validate-ibm              Basic terraform sanity check; export TERRAFORM_EXPORTS first
  travis/docker-login                 Login into docker hub
  travis/docker-tag-and-push          Tag & Push according Travis environment variables

```
