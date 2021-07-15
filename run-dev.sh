#!/bin/bash
set -x

source build.env

echo "Starting the junari/odoo:$ODOO_VERSION image for development ..."
docker run --rm -it --name=junari-odoo-dev-$ODOO_VERSION \
    -v junari-odoo-data-$ODOO_VERSION:/opt/odoo/data \
    -v junari-odoo-vscode-$ODOO_VERSION:/opt/odoo/.vscode \
    -v junari-odoo-custom-addons-$ODOO_VERSION:/opt/odoo/custom_addons \
    -v junari-odoo-home-$ODOO_VERSION:/home/odoo \
    -p 8069:8069 --env-file=odoo.env \
    junari/odoo:$ODOO_VERSION bash
