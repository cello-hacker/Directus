ARG TAG=latest
FROM directus/directus:${TAG}

CMD []

USER root

RUN apk upgrade --no-cache \
    && apk add --no-cache \
        mariadb-client \
        postgresql-client

ENTRYPOINT [ "/entrypoint.sh" ]
COPY entrypoint.sh /

#COPY entrypoint.d/ /entrypoint.d/
