# --- Build stage ---
FROM node:24-alpine AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable && corepack prepare pnpm@9.6.0 --activate

FROM base AS build
WORKDIR /app
RUN apk add --no-cache git

# Clone the latest code from GitHub
RUN git clone --depth=1 https://github.com/imputnet/cobalt.git app

WORKDIR /app/app

ARG WEB_DEFAULT_API
ARG WEB_HOST
ENV WEB_DEFAULT_API=${WEB_DEFAULT_API}
ENV WEB_HOST=${WEB_HOST}

RUN pnpm install --frozen-lockfile
WORKDIR /app/app/web
RUN pnpm build

FROM base AS web
WORKDIR /app/web

COPY --from=build --chown=node:node /app/app/web/build ./build
COPY --from=build --chown=node:node /app/app/web/package.json ./
RUN pnpm add -g serve

USER node
EXPOSE 8080
CMD ["serve", "-s", "build", "-l", "8080"]