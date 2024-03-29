ARG := $(arg)
PROJECT_ROOT := $(shell pwd)
DOCKER_WORKDIR := /app
DOCKER_LOCAL_RUN_BINDS := \
	--mount type=bind,source=$(PROJECT_ROOT)/jest.config.js,target=$(DOCKER_WORKDIR)/jest.config.js,readonly \
	--mount type=bind,source=$(PROJECT_ROOT)/node_modules,target=$(DOCKER_WORKDIR)/node_modules,readonly \
	--mount type=bind,source=$(PROJECT_ROOT)/package.json,target=$(DOCKER_WORKDIR)/package.json,readonly \
	--mount type=bind,source=$(PROJECT_ROOT)/src,target=$(DOCKER_WORKDIR)/src,readonly \
	--mount type=bind,source=$(PROJECT_ROOT)/tsconfig.json,target=$(DOCKER_WORKDIR)/tsconfig.json,readonly

docker/ci/analyze-code:
	docker run \
		--name sgrb_ci_analyze_code \
		--rm \
		--tty \
		sgrb_ci \
		npm run prettier:check

docker/ci/test:
	docker run \
		--name sgrb_ci_test \
		--rm \
		sgrb_ci \
		npm run test:ci

docker/local/build:
	DOCKER_BUILDKIT=1 \
		docker build \
			--tag sgrb_local \
			--target local \
			--progress=tty \
			.

docker/local/command:
	docker run $(DOCKER_LOCAL_RUN_BINDS) \
		--name sgrb_local_command \
		--rm \
		--tty \
		sgrb_local \
		$(ARG)

docker/local/console:
	docker run \
		--interactive \
		--rm \
		--tty \
		sgrb_local \
		/bin/bash

docker/local/dev:
	docker run $(DOCKER_LOCAL_RUN_BINDS) \
		--name sgrb_local_dev \
		--publish 4000:4000 \
		--rm \
		--tty \
		sgrb_local \
		npm run dev

docker/local/stop:
	docker stop sgrb_local_dev
