#!/bin/bash
set -x

docker run --rm -it \
    -v $PWD/config:/etc/odoo \
    -v $PWD/odoo:/opt/odoo/odoo \
    -v $PWD/custom_addons:/opt/odoo/custom_addons \
    -v $PWD/data:/opt/odoo/data \
    -p 8069:8069 --env-file=./odoo.env odoo-dev $@
