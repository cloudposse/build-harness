## What
* Added targets to sync codefresh pipelines from code with templates

## Why
* To have a repeatable, stable  and scalable process of creation/update codefresh pipelines

## Usage
* Create new repo that would contain templates for your pipelines

```
{repo}                                  # Repository for codefresh sync
├── templates                           # Directory for templates
│   ├── {account_x}                     # Templates for account x
│   │    ├── {template_x_x1}.yaml       # Pipeline template {template_x_x1}
│   │    └── {template_x_y1}.yaml       # Pipeline template {template_x_y1}
│   └── {account_y}                     # Templates for account y
│        ├── {template_y_x1}.yaml       # Pipeline template {template_y_x1}
│        └── {template_y_y1}.yaml       # Pipeline template {template_y_y1}
└── Makefile                            # Makefile
```

* Fill templates with [pipelines](https://codefresh-io.github.io/cli/pipelines/spec/). You can use `{{ (ds "repository") }}` as placeholder for repo name
* Add to the `Makefile` 
```
export DEFAULT_HELP_TARGET ?= help
export HELP_FILTER ?= help|init|codefresh/sync
export DOCKER_NETWORK ?= default
export BUILD_HARNESS_BRANCH ?= 0.14.5
-include $(shell curl -sSL -o .build-harness "https://git.io/build-harness"; echo .build-harness)

## Project name
PROJECT ?= project_z

## Repos to sync pipelines
REPOSITORIES ?= api front

## Codefresh accounts to operate with
ACCOUNTS ?= account_x account_y

## Pipelines for `acccount_x`
ACCOUNT_X_PIPELINES ?= template_x_x1 template_x_y1

## Pipelines for `acccount_y`
ACCOUNT_Y_PIPELINES ?= template_y_x1 template_y_y1
```
* Do Auth for accounts. You can get `CF_API_KEY` [here](https://g.codefresh.io/account-conf/tokens)
```
make codefresh/sync/auth/account_x CF_API_KEY={CF_API_KEY for `account_x`}
make codefresh/sync/auth/account_y CF_API_KEY={CF_API_KEY for `account_y`}
```

* For dry-run use
```
make codefresh/sync/diff
```

* For sync use 
```
make codefresh/sync/apply
```

* You can filter repos, accounts and pipelines that are syncing with env variables `REPOSISTORIES` `ACCOUNTS` `PIPELINES`

```
make codefresh/sync/diff REPOSITORIES=api ACCOUNTS=account_x PIPELINES=template_x_x1

make codefresh/sync/apply REPOSITORIES=api ACCOUNTS=account_x PIPELINES=template_x_x1
```
