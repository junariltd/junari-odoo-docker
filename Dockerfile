FROM ubuntu:18.04

# Create odoo user and directories and set permissions
RUN useradd -ms /bin/bash odoo \
    && mkdir odoo /etc/odoo /opt/odoo \
    && chown -R odoo:odoo odoo /etc/odoo /opt/odoo

WORKDIR /opt/odoo

# Speed up updates from NZ...
# COPY src/sources.list.nz /etc/apt/sources.list

# Install System dependencies
RUN set -x; \
    apt-get update \
    && apt-get install -y curl \
    && curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb \
    && apt-get install -y --no-install-recommends \
    ./wkhtmltox.deb \
    postgresql-client \
    build-essential \
    python3 \
    python3-setuptools \
    python3-pip \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    libldap2-dev \
    libssl-dev \
    libsasl2-dev \
    && rm -rf /var/lib/apt/lists/* wkhtmltox.deb

# Install Odoo dependencies
COPY odoo/requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt

# Define runtime configuration
COPY src/entrypoint.sh ./
ENV ODOO_RC /etc/odoo/odoo.conf
USER odoo
EXPOSE 8069
ENTRYPOINT ["/opt/odoo/entrypoint.sh"]
CMD ["odoo"]