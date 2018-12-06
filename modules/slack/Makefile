export SLACK_NOTIFIER ?= slack-notifier

export SLACK_USER_NAME ?= CodeFresh
export SLACK_ICON_EMOJI ?= :rocket:
export SLACK_COLOR ?= good
export SLACK_COLOR_DESTROY ?= \#000000
export SLACK_AUTHOR_NAME ?= Auto Deploy Robot
export SLACK_AUTHOR_LINK ?= https://cloudposse.com/
export SLACK_AUTHOR_ICON ?= https://cloudposse.com/wp-content/uploads/sites/29/2018/02/small-cute-robot-square.png
export SLACK_THUMB_URL ?= https://cloudposse.com/wp-content/uploads/sites/29/2018/02/SquareLogo2.png
export SLACK_FOOTER ?= Helm Deployment
export SLACK_FOOTER_ICON ?= https://cloudposse.com/wp-content/uploads/sites/29/2018/02/kubernetes.png
export SLACK_TEXT ?= 


## Send webhook notification to slack
slack/notify: packages/install/slack-notifier
	$(call assert-set,SLACK_WEBHOOK_URL)
	$(call assert-set,SLACK_NOTIFIER_TEMPLATE)
	$(call assert-set,SLACK_NOTIFIER)
	@$(BUILD_HARNESS_PATH)/bin/slack-notify.sh

## Send notification to slack using "build" template
slack/notify/build:
	$(call assert-set,ACTION)
	$(call assert-set,NAME)
	$(call assert-set,BUILD_URL)
	$(call assert-set,BUILD_TIMESTAMP)
	$(call assert-set,BUILD_TRIGGER)
	$(call assert-set,REPO_OWNER)
	$(call assert-set,REPO_NAME)
	$(call assert-set,GIT_COMMIT_SHORT)
	$(call assert-set,GIT_COMMIT_URL)
	$(call assert-set,GIT_COMMIT_MESSAGE)
	$(call assert-set,GIT_COMMIT_AUTHOR)
	$(call assert-set,GIT_COMMIT_TIMESTAMP)
	$(call assert-set,GIT_BRANCH_TAG)

	@$(MAKE) slack/notify \
		SLACK_NOTIFIER_TEMPLATE=$(BUILD_HARNESS_PATH)/templates/slack-notifier/build.env

## Send notification to slack using "deploy" template
slack/notify/deploy:
	$(call assert-set,ACTION)
	$(call assert-set,NAME)
	$(call assert-set,ENVIRONMENT)
	$(call assert-set,NAMESPACE)
	$(call assert-set,RELEASE_NAME)
	$(call assert-set,BUILD_URL)
	$(call assert-set,BUILD_TIMESTAMP)
	$(call assert-set,BUILD_TRIGGER)
	$(call assert-set,REPO_OWNER)
	$(call assert-set,REPO_NAME)
	$(call assert-set,GIT_COMMIT_SHORT)
	$(call assert-set,GIT_COMMIT_URL)
	$(call assert-set,GIT_COMMIT_MESSAGE)
	$(call assert-set,GIT_COMMIT_AUTHOR)
	$(call assert-set,GIT_COMMIT_TIMESTAMP)
	$(call assert-set,GIT_BRANCH_TAG)

	@$(MAKE) slack/notify \
		SLACK_NOTIFIER_TEMPLATE=$(BUILD_HARNESS_PATH)/templates/slack-notifier/deploy.env
