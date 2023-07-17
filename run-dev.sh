#!/bin/bash
set -x

source build.env

echo "Starting the odoo:$ODOO_VERSION image for development ..."
docker run --rm -it --name=-odoo-dev-$ODOO_VERSION \
    -v odoo-data-$ODOO_VERSION:/opt/odoo/data \
    -v odoo-vscode-$ODOO_VERSION:/opt/odoo/.vscode \
    -v odoo-custom-addons-$ODOO_VERSION:/opt/odoo/custom_addons \
    -v odoo-home-$ODOO_VERSION:/home/odoo \
    -p 8069:8069 --env-file=odoo.env \
    odoo:$ODOO_VERSION bash
