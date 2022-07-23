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
		--name sgr_run_analyze_code \
		--rm \
		--tty \
		sgrb \
		npm run prettier:check

docker/ci/test:
	docker run \
		--name sgr_run_ci \
		--rm \
		sgrb \
		npm run test:ci

docker/local/build:
	DOCKER_BUILDKIT=1 \
		docker build \
			--tag sgrb_local \
			--target local \
			--progress=tty \
			.

docker/local/console:
	docker run \
		--interactive \
		--rm \
		--tty \
		sgrb_local \
		/bin/bash

docker/local/dev:
	docker run $(DOCKER_LOCAL_RUN_BINDS) \
		--name sgrb_local_run \
		--publish 4000:4000 \
		--rm \
		--tty \
		sgrb_local \
		npm run dev

docker/local/test:
	docker run $(DOCKER_LOCAL_RUN_BINDS) \
		--name sgrb_local_run \
		--rm \
		--tty \
		sgrb_local \
		npm run test:local -- $(ARG)

docker/local/stop:
	docker stop sgrb_local_run
