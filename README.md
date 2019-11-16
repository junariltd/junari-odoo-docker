# Docker image for local Junari Odoo development

## Set-up

* Checkout odoo into an `odoo` subdirectory
* Checkout custom addons into a `custom_addons` directory
* Create an empty `data` directory

## Building

```sh
./build.sh
```

## Using

```sh
./run.sh
```

You can also pass any `odoo-bin` args via `run.sh`, e.g.:

```bash
# Initialise a new database (with demo data disabled)
./run.sh odoo -d db_name -i base --without-demo=all

# Run with a specific database
./run.sh odoo -d db_name

# Access the odoo shell for a specific database
./run.sh odoo-shell -d db_name

# Access bash inside the container
./run.sh bash
```