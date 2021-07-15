#!/bin/bash
set -x

source build.env

echo "Starting the junari/odoo:$ODOO_VERSION image for development ..."
docker run --rm -it \
    -v junari-odoo-data-$ODOO_VERSION:/opt/odoo/data \
    -p 8069:8069 --env-file=odoo.env junari/odoo:$ODOO_VERSION $@
