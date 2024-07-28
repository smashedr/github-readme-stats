FROM node:lts-alpine

LABEL org.opencontainers.image.source="https://github.com/smashedr/github-readme-stats"
LABEL org.opencontainers.image.description="anuraghazra/github-readme-stats"
LABEL org.opencontainers.image.authors="smashedr"

ENV TZ=UTC

ENV NODE_ENV production

#RUN --mount=type=bind,source=./app/package.json,target=package.json \
#    --mount=type=bind,source=./app/package-lock.json,target=package-lock.json \
#    --mount=type=cache,target=/root/.npm \
#    npm install &&\
#    npm i express --no-save &&\
#    apk add --no-cache curl

COPY docker-entrypoint.sh /
WORKDIR /app
COPY --chown=node:node app .
RUN --mount=type=cache,target=/root/.npm \
    npm ci && npm i express --no-save

USER node
ENTRYPOINT ["sh", "/docker-entrypoint.sh"]
