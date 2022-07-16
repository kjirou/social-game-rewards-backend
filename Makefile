ARG := $(arg)
PROJECT_ROOT := $(shell pwd)
DOCKER_WORKDIR := /app
DOCKER_LOCAL_RUN_BINDS := \
	--mount type=bind,source=$(PROJECT_ROOT)/jest.config.js,target=$(DOCKER_WORKDIR)/jest.config.js,readonly \
	--mount type=bind,source=$(PROJECT_ROOT)/node_modules,target=$(DOCKER_WORKDIR)/node_modules,readonly \
	--mount type=bind,source=$(PROJECT_ROOT)/package.json,target=$(DOCKER_WORKDIR)/package.json,readonly \
	--mount type=bind,source=$(PROJECT_ROOT)/src,target=$(DOCKER_WORKDIR)/src,readonly \
	--mount type=bind,source=$(PROJECT_ROOT)/tsconfig.json,target=$(DOCKER_WORKDIR)/tsconfig.json,readonly

docker/ci/build:
	DOCKER_BUILDKIT=1 \
		docker build \
			--tag sgr_ci \
			--target ci \
			--progress=tty \
			.

docker/ci/test:
	docker run \
		--name sgr_run_ci \
		--rm \
		--tty \
		sgr_ci \
		npm run test:ci

docker/local/build:
	DOCKER_BUILDKIT=1 \
		docker build \
			--tag sgr_local \
			--target local \
			--progress=tty \
			.

docker/local/console:
	docker run \
		--interactive \
		--rm \
		--tty \
		sgr_local \
		/bin/bash

docker/local/dev:
	docker run $(DOCKER_LOCAL_RUN_BINDS) \
		--name sgr_local_run \
		--publish 4000:4000 \
		--rm \
		--tty \
		sgr_local \
		npm run dev

docker/local/test:
	docker run $(DOCKER_LOCAL_RUN_BINDS) \
		--name sgr_local_run \
		--rm \
		--tty \
		sgr_local \
		npm run test:local -- $(ARG)

docker/local/stop:
	docker stop sgr_local_run
