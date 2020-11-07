# Junari Odoo Docker image

Junari Open Source Docker image for Odoo Development and Production

* Ubuntu 18.04 LTS
* Odoo Community Edition, installed from source in `/opt/odoo`
* Supports custom addons in `/opt/odoo/custom_addons`
* Includes an `odoo-config` script for modifying the odoo config file in derrived images
* Includes Git and SSH clients for development
* Includes Visual Studio Code folder mount points
* Allows easy passing of additional odoo args, or running other commands like the bash shell

# Set-up

## Prerequisites

* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* Access to a PostgreSQL 9+ Database Server

## Configuring

This image requires the following environment variables.

* `DB_HOST` - Postgres Database server address. Set to `host.docker.internal` to use your local machine.
* `DB_PORT` - Postgres Database server port. Normally 5432
* `DB_USER` - Odoo database user. This must NOT be your PostgreSQL super user (`postgres`)
* `DB_PASSWORD` - Odoo database user password.

We recommend creating an `odoo.env` file to store your database configuration. Check out
[odoo.env-example](https://github.com/junariltd/junari-odoo-docker/blob/master/odoo.env-example)
for an example.

## Overriding Odoo Configuration Settings

This image ships with a default `odoo.conf` in `/etc/odoo`. You can either replace this file with
your own version, or use our `odoo-config` tool to updae individual settings.

To override individual settings, create and build you own `Dockerfile` with content such as the below:

```Dockerfile
FROM junari/odoo

RUN odoo-config addons_path+=,/opt/odoo/custom_addons/my_lib/addons \
                list_db=True
```
(you can either append to existing settings using `+=`, or overwrite them using `=`)

# Creating a database and running the image

The following example walks you through creating a new Odoo database using this image:

1. In a new folder, create an `odoo.env` file, as above

2. Create a blank PostgreSQL database owned by your Odoo database user, e.g.

```sql
CREATE DATABASE odoo13 OWNER odoo ENCODING UTF8;
```

3. Run this image with the following command in the Terminal (or in
   [Git Bash](https://gitforwindows.org/) on Windows) to initialise your new
   Odoo database

```bash
docker run --rm -it \
    -v junari-odoo-data:/opt/odoo/data \
    -p 8069:8069 \
    --env-file=odoo.env \
    junari/odoo \
    odoo -d odoo13 -i base --without-demo=all --load-language=en_GB --stop-after-init
```

(where `odoo13` is the new database name)

4. Now that your database has been initialised, you can restart it with a
   simpler command. You might find it useful to save the below into a
   `start-odoo.sh` script, which you can run instead of typing it out!

```bash
docker run --rm -it \
    -v junari-odoo-data:/opt/odoo/data \
    -p 8069:8069 \
    --env-file=odoo.env \
    junari/odoo odoo -d odoo13
```

Your Odoo system should now be accessible at http://localhost:8069 . You can log
in using the default user: admin, password: admin

# Development

## Running

The below script should be run in Git Bash on windows, or in the Terminal application on Mac and Linux

```bash
# Run the junari/odoo docker image with default settings
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
# Re-build the images (with the latest ubuntu)
./build.sh
```
