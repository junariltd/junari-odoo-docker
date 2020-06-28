#!/bin/bash
set -x

echo "Starting junari/odoo image for development ..."
docker run --rm -it --name=junari-odoo-dev \
    -v junari-odoo-data:/opt/odoo/data \
    -v junari-odoo-vscode:/opt/odoo/.vscode \
    -v junari-odoo-custom-addons:/opt/odoo/custom_addons \
    -v junari-odoo-home:/home/odoo \
    -p 8069:8069 --env-file=odoo.env \
    junari/odoo bash
