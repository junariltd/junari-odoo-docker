#!/bin/bash
set -e

# Set default values if variables are not defined
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5432}"
DB_USER="${DB_USER:-odoo}"
DB_PASSWORD="${DB_PASSWORD:-password}"
ODOO_EXTRA_ARGS="${ODOO_EXTRA_ARGS:-}"

if [ "$1" = 'odoo' ]; then
    shift
    cd odoo
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
