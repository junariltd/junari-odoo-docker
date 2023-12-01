
FROM python:3.10-slim-bullseye

SHELL ["/bin/bash", "-xo", "pipefail", "-c"]

ARG ODOO_VERSION
ARG ODOO_REVISION
ARG DEBIAN_FRONTEND=noninteractive

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG en_US.UTF-8

# Install dependencies (from Odoo install documentation)
RUN apt-get update && \
    apt-get install -y libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev \
    libtiff5-dev libjpeg-dev libopenjp2-7-dev zlib1g-dev libfreetype6-dev \
    liblcms2-dev libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev libpq-dev

# Install additional tools needed for build & run
RUN apt-get install -y \
    gcc g++ curl git nano postgresql-client

# install wkhtmltox for PDF reports
RUN curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.jammy_${WKHTMLTOPDF_ARCH}.deb\
    && apt-get install -y ./wkhtmltox.deb \
    && rm wkhtmltox.deb

# Install Node
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

# Create odoo user and directories and set permissions
RUN useradd -ms /bin/bash odoo \
    && mkdir /etc/odoo /opt/odoo /opt/odoo/scripts \
    && chown -R odoo:odoo /etc/odoo /opt/odoo

WORKDIR /opt/odoo

# Install Odoo and dependencies from source and check out specific revision
USER odoo
RUN git clone --branch=$ODOO_VERSION --depth=1000 https://github.com/odoo/odoo.git odoo
RUN cd odoo && git reset --hard $ODOO_REVISION

# Patch odoo requirements file
RUN sed -i "s/gevent==21\.8\.0 ; python_version > '3\.9'/gevent==22\.10\.2 ; python_version > '3\.9'/" odoo/requirements.txt \
    && sed -i "s/greenlet==1\.1\.2 ; python_version  > '3\.9'/greenlet==2\.0\.1 ; python_version > '3\.9'/" odoo/requirements.txt
#     && sed -i "s/lxml==4\.6\.5/lxml==4\.9\.2/" odoo/requirements.txt \
#     && sed -i "s/reportlab==3\.5\.59/reportlab==3\.6\.12/" odoo/requirements.txt

# Install Odoo python package requirements
USER root
RUN pip3 install pip --upgrade
RUN pip3 install --no-cache-dir -r odoo/requirements.txt

# Define runtime configuration
COPY src/entrypoint.sh /opt/odoo
COPY src/scripts/* /opt/odoo/scripts
COPY src/odoo.conf /etc/odoo
RUN chown odoo:odoo /etc/odoo/odoo.conf

USER odoo

RUN mkdir /opt/odoo/data /opt/odoo/custom_addons \
    /opt/odoo/.vscode /home/odoo/.vscode-server

ENV ODOO_RC /etc/odoo/odoo.conf
ENV PATH="/opt/odoo/scripts:${PATH}"

EXPOSE 8069
ENTRYPOINT ["/opt/odoo/entrypoint.sh"]
CMD ["odoo"]
