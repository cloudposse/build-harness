SLACK_NOTIFIER ?= slack-notifier

SLACK_USER_NAME ?= CodeFresh
SLACK_ICON_EMOJI ?= ":rocket:"
SLACK_COLOR ?= good
SLACK_AUTHOR_NAME ?= Auto Deploy Robot
SLACK_AUTHOR_LINK ?= https://cloudposse.com/
SLACK_AUTHOR_ICON ?= https://cloudposse.com/wp-content/uploads/sites/29/2018/02/small-cute-robot-square.png
SLACK_THUMB_URL ?= https://cloudposse.com/wp-content/uploads/sites/29/2018/02/SquareLogo2.png
SLACK_FOOTER ?= Helm Deployment
SLACK_FOOTER_ICON ?= https://cloudposse.com/wp-content/uploads/sites/29/2018/02/kubernetes.png
SLACK_TEXT ?= "\n"

slack/notify: packages/install/slack-notifier
	$(call assert-set,SLACK_WEBHOOK_URL)
	$(call assert-set,SLACK_NOTIFIER_TEMPLATE)
	$(call assert-set,SLACK_NOTIFIER)
	$(BUILD_HARNESS_PATH)/bin/slack-notify.sh

slack/notify/build:
	$(call assert-set,NAME)
	$(call assert-set,ARTIFACT)
	$(call assert-set,BUILD_URL)
	$(call assert-set,BUILD_TIMESTAMP)  # <!date^$(BUILD_UNIX_TIMESTAMP)^{date_num} {time_secs}|Time format failed!!!>
	$(call assert-set,BUILD_TRIGGER)
	$(call assert-set,REPO_OWNER)
	$(call assert-set,REPO_NAME)
	$(call assert-set,COMMIT) # <$(COMMIT_URL)|$(GIT_COMMIT_SHORT)>
	$(call assert-set,GIT_COMMIT_MESSAGE)
	$(call assert-set,GIT_COMMIT_AUTHOR)
	$(call assert-set,COMMIT_TIMESTAMP)  # <!date^$(GIT_COMMIT_TIMESTAMP)^{date_num} {time_secs}|Time format failed!!!>
	$(call assert-set,GIT_BRANCH)
	$(call assert-set,GIT_TAG)

	$(MAKE) slack/notify \
		SLACK_NOTIFIER_TEMPLATE=slack-notifier.build.template.env

slack/notify/deploy:
	$(call assert-set,ACTION)
	$(call assert-set,NAME)
	$(call assert-set,ENVIRONMENT)
	$(call assert-set,NAMESPACE)
	$(call assert-set,RELEASE_NAME)
	$(call assert-set,BUILD_URL)
	$(call assert-set,BUILD_TIMESTAMP)  # <!date^$(BUILD_UNIX_TIMESTAMP)^{date_num} {time_secs}|Time format failed!!!>
	$(call assert-set,BUILD_TRIGGER)
	$(call assert-set,REPO_OWNER)
	$(call assert-set,REPO_NAME)
	$(call assert-set,COMMIT) # <$(COMMIT_URL)|$(GIT_COMMIT_SHORT)>
	$(call assert-set,GIT_COMMIT_MESSAGE)
	$(call assert-set,GIT_COMMIT_AUTHOR)
	$(call assert-set,COMMIT_TIMESTAMP)  # <!date^$(GIT_COMMIT_TIMESTAMP)^{date_num} {time_secs}|Time format failed!!!>
	$(call assert-set,GIT_BRANCH)
	$(call assert-set,GIT_TAG)

	$(MAKE) slack/notify \
		SLACK_NOTIFIER_TEMPLATE=slack-notifier.deploy.template.env
