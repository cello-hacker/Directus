#!/usr/bin/env sh
[ -n "${STORAGE_LOCAL_ROOT}" ] && mkdir -p "${STORAGE_LOCAL_ROOT}" && chmod 0777 "${STORAGE_LOCAL_ROOT}"
[ -n "${EXTENSIONS_PATH}" ] && mkdir -p "${EXTENSIONS_PATH}" && chmod 0777 "${EXTENSIONS_PATH}"

npx directus bootstrap

if [ -d "/entrypoint.d" ] && [ -n "$(ls /entrypoint.d)" ]; then
    case ${DB_CLIENT} in
        mysql)
            CMD="mysql -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p${DB_PASSWORD} -D ${DB_DATABASE}"
            CMD_SQL="${CMD} -BNe"
            CMD_SQL_FILE="${CMD} -BN <"
            ;;

        pg)
            export PGPASSWORD="${DB_PASSWORD}"
            export PGOPTIONS="--search_path=${DB_SEARCH_PATH}"
            CMD="psql -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USER} -d ${DB_DATABASE}"
            CMD_SQL="${CMD} -Atc"
            CMD_SQL_FILE="${CMD} -Atf"
            ;;
    esac

    if [ -n "${CMD}" ]; then
        COUNT_DIRECTUS_COLLECTIONS="$(${CMD_SQL} 'select count(*) from directus_collections;')"
        if [ "${COUNT_DIRECTUS_COLLECTIONS}" == "0" ]; then
            find /entrypoint.d -type f | sort | while read SQL_FILE; do
                eval ${CMD_SQL_FILE} ${SQL_FILE}
            done
        fi
    fi
fi

npx directus start
