#!/usr/bin/env sh
. directus/.env

DOCKER_COMPOSE_OPTS="-f directus/docker-compose.yml"

docker compose ${DOCKER_COMPOSE_OPTS} down
