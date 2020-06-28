#!/bin/bash

echo "Building the junari-odoo-os image..."
docker build -t junari-odoo-os -f junari-odoo-os.dockerfile --pull .

echo "Building the junari-odoo image..."
docker build -t junari-odoo -f junari-odoo.dockerfile .
