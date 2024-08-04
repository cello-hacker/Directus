#!/usr/bin/env sh
DB_CLIENT=mysql
DB_HOST=mariadb
DB_PORT=3306
DB_DATABASE=directus
DB_USER=root
DB_PASSWORD=r00t
#DB_CLIENT=pg
#DB_HOST=postgres
#DB_PORT=5432
#DB_DATABASE=postgres
#DB_SEARCH_PATH=directus
#DB_USER=postgres
#DB_PASSWORD=postgres

DB_CONTAINER_NAME="directus-${DB_HOST}-1"
DB_TABLES="directus_collections directus_fields directus_presets directus_relations"

case ${DB_CLIENT} in
    mysql)
        CMD_DUMP="mysqldump -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p${DB_PASSWORD} --no-create-info --complete-insert --skip-extended-insert ${DB_DATABASE} "
        ;;

    pg)
        CMD_DUMP="PGPASSWORD='${DB_PASSWORD}' pg_dump -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USER} -d ${DB_DATABASE} --data-only --column-inserts --disable-triggers --table=${DB_SEARCH_PATH}."
        ;;
esac

if [ -n "${CMD_DUMP}" ]; then
    mkdir -p entrypoint.d

    CMD="docker exec -i ${DB_CONTAINER_NAME} sh -c"
    N=0
    for DB_TABLE in ${DB_TABLES}; do
        N=$((N+1))
        eval ${CMD} \"${CMD_DUMP}${DB_TABLE}\" > entrypoint.d/${DB_CLIENT}-${N}-${DB_TABLE}.sql
    done
fi
