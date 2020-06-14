#!/bin/bash
set -e
cd odoo
if [ "$1" = 'odoo' ]; then
    shift
    exec ./odoo-bin \
        "--db_host=$DB_HOST" \
        "--db_port=$DB_PORT" \
        "--db_user=$DB_USER" \
        "--db_password=$DB_PASSWORD" \
        $ODOO_EXTRA_ARGS "$@"
elif [ "$1" = 'odoo-shell' ]; then
    shift
    exec ./odoo-bin shell \
        "--db_host=$DB_HOST" \
        "--db_port=$DB_PORT" \
        "--db_user=$DB_USER" \
        "--db_password=$DB_PASSWORD" \
        $ODOO_EXTRA_ARGS "$@"
else
    exec "$@"
fi