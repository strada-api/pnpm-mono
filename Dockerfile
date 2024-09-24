FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN npm install -g pnpm

FROM base AS build
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN pnpm install --no-frozen-lockfile
RUN pnpm run -r build
RUN pnpm deploy --filter=server --prod /prod/server
RUN pnpm deploy --filter=websocket --prod /prod/websocket

FROM base AS server
COPY --from=build /prod/server /prod/server
WORKDIR /prod/server
EXPOSE 3005
CMD [ "pnpm", "start" ]

FROM base AS websocket
COPY --from=build /prod/websocket /prod/websocket
WORKDIR /prod/websocket
EXPOSE 3105
CMD [ "pnpm", "start" ]