# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

RVM_VERSION := 2.5.5
PROJECT_TAG := TEMPLATE ## todo change to project tag

TARGET_MAX_CHAR_NUM=20
## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Initialization of the working environ
init:
	# Install bundler if not installed
	if ! gem spec bundler > /dev/null 2>&1; then\
  		echo "bundler gem is not installed!";\
  		-gem install bundler -v 1.17.3;\
	fi

    bash -lc "source ~/.rvm/scripts/rvm && rvm use ${RVM_VERSION}@${PROJECT_TAG} --create && rvm gemset name"
	-bundle install
	-bundle exec pod repo update

	sh ./scripts/init_certs.sh

## Used to build both target. Usually, it is not called manually, it is necessary for the CI to work.
build:
	bundle exec fastlane build clean:true

## Allows you to perfrom swiftlint lint command.
lint:
	./Pods/SwiftLint/swiftlint lint --config .swiftlint.yml

## Allows you to perfrom swiftlint autocorrect command.
format:
	./Pods/SwiftLint/swiftlint autocorrect --config .swiftlint.yml

## Used to upload debug build in fabric. Usually, it is not called manually, it is necessary for the CI to work.
beta:
	bundle exec fastlane beta

## Used to upload debug build in app_store. Usually, it is not called manually, it is necessary for the CI to work.
release:
	bundle exec fastlane release

## Allows you to perform pod install command via bundler settings. Use it instead plain pod install command.
pod_install:
	bundle exec pod install

## Command for increasing build number and commit/push new tag.
prepare_for_beta:
	bundle exec fastlane prepare_for_beta type:"test"

## Nothing to do, stub method, it is necessary for the CI to work.
sonar:
	@echo does noting