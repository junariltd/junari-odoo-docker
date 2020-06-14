FROM junari-odoo-os:latest

# Create odoo user and directories and set permissions
RUN useradd -ms /bin/bash odoo \
    && mkdir odoo /etc/odoo /opt/odoo \
    && chown -R odoo:odoo odoo /etc/odoo /opt/odoo

WORKDIR /opt/odoo

# Install Odoo and dependencies from latest source
USER odoo
RUN git clone --branch=13.0 --depth=1 https://github.com/odoo/odoo.git odoo

USER root
RUN pip3 install --no-cache-dir -r odoo/requirements.txt

# Define runtime configuration
COPY src/entrypoint.sh ./
COPY config/odoo.conf /etc/odoo
ENV ODOO_RC /etc/odoo/odoo.conf
USER odoo
EXPOSE 8069
ENTRYPOINT ["/opt/odoo/entrypoint.sh"]
CMD ["odoo"]