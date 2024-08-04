#!/usr/bin/env sh
. directus/.env

DOCKER_COMPOSE_OPTS="-f directus/docker-compose.yml"

SERVICES="\
    directus-postgres \
    postgres \
"

[ "$1" != "--no-pull" ] && \
    docker compose ${DOCKER_COMPOSE_OPTS} pull --include-deps ${SERVICES}

docker compose ${DOCKER_COMPOSE_OPTS} up ${SERVICES}
