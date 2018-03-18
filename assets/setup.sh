#!/bin/bash

if [ -e /shopware.sql ]
then

    HAS_MYSQL=1

    while [ $HAS_MYSQL != 0 ]
    do
        echo "Waiting for mysql server..."
        sleep 1
        mysql -h${SHOPWARE_DB_HOST} -u${SHOPWARE_DB_USER} -p${SHOPWARE_DB_PASSWORD} -e "use ${SHOPWARE_DB_NAME}"
        HAS_MYSQL=$?
    done

    echo "Mysql server detected."

    mysql -u${SHOPWARE_DB_USER} -p${SHOPWARE_DB_PASSWORD} -h${SHOPWARE_DB_HOST} ${SHOPWARE_DB_NAME} < /shopware.sql
    rm /shopware.sql

    php /var/www/html/bin/console sw:media:migrate

fi

if [[ ! -z "${PLUGIN_NAME}" ]]; then
    php /var/www/html/bin/console sw:plugin:install --activate ${PLUGIN_NAME}
fi

apache2-foreground
