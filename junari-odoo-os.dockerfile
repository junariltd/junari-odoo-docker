FROM ubuntu:18.04

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
    git \
    openssh-client \
    && rm -rf /var/lib/apt/lists/* wkhtmltox.deb
