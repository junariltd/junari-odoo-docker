#!/bin/bash

echo "Building the junari/odoo image..."
docker build \
    --build-arg ODOO_VERSION=13.0 \
    --build-arg ODOO_REVISION=ad62f87 \
    -t junari/odoo:13.0 .
