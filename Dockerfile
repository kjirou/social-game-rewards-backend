#
# Base
#
FROM node:16.15.0-slim AS base

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

ENV WORKDIR_ROOT=/app
WORKDIR ${WORKDIR_ROOT}

# Create to user and privileges.
ARG GROUP_ID=1100
ARG USER_ID=1100
RUN groupadd --system --gid ${GROUP_ID} appgroup && \
    useradd --system --gid ${GROUP_ID} --create-home --uid ${USER_ID} appuser && \
    chown appuser:appgroup ${WORKDIR_ROOT}
USER $USER_ID:$GROUP_ID


#
# Local
#
FROM base AS local

ENV NODE_ENV=development

EXPOSE 4000


#
# CI
#
FROM base AS ci

ENV NODE_ENV=development

COPY --chown=appuser:appgroup package.json package-lock.json .
RUN npm ci

COPY --chown=appuser:appgroup \
    .prettierignore \
    .prettierrc.json \
    jest.config.js \
    tsconfig.json \
    .
COPY --chown=appuser:appgroup src src
