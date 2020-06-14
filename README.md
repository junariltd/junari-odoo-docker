# Junari Odoo Docker images

Open Source Docker images for Odoo Development and Production

* Ubuntu 18.04 LTS
* Odoo Community Edition, installed from source in `/opt/odoo`
* Supports custom addons in `/opt/odoo/custom_addons`

## Running the `junari-odoo` image

### Prerequisites

* [Docker Desktop](https://www.docker.com/products/docker-desktop)

### Running

The below script should be run in Git Bash on windows, or in the Terminal application on Mac and Linux

```bash
# Run the junari-odoo docker image
./run.sh
```

You can also pass any `odoo-bin` args via `run.sh`, e.g.:

```bash
# Initialise a new database (with demo data disabled)
./run.sh odoo -d db_name -i base --without-demo=all --load-language=en_GB

# Run with a specific database
./run.sh odoo -d db_name

# Access the odoo shell for a specific database
./run.sh odoo-shell -d db_name

# Access bash inside the container
./run.sh bash
```

## Re-building the image

```bash
# Re-build the images
./build.sh
```
