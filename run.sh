#!/bin/bash
set -x

ODOO_VERSION=13.0

docker run --rm -it \
    -v junari-odoo-data:/opt/odoo/data \
    -p 8069:8069 --env-file=odoo.env junari/odoo:$ODOO_VERSION $@
