FROM resin/raspberry-pi-python:3.6

# Scripts in /scripts are required to be in the PATH to run properly as certbot's hooks
RUN mkdir /scripts
ENV PATH /scripts:$PATH

# Versioning
ENV LEXICON_VERSION 2.1.16
ENV CERTBOT_VERSION 0.20.0

# Let's Encrypt configuration
ENV LETSENCRYPT_STAGING false
ENV LETSENCRYPT_USER_MAIL noreply@example.com

# Lexicon configuration
ENV LEXICON_PROVIDER cloudflare

# Container specific configuration
ENV PFX_EXPORT false
ENV PFX_EXPORT_PASSPHRASE ""
ENV CERTS_DIRS_MODE 0750
ENV CERTS_FILES_MODE 0640
ENV CERTS_USER_OWNER root
ENV CERTS_GROUP_OWNER root
ENV RENEWED_LINEAGE "/etc/letsencrypt/"

# Install dependencies, certbot, lexicon, prepare for first start and clean
RUN apt-get -y update && \
    apt-get -y install --no-install-recommends \
      rsyslog \
      openssl \
      libssl-dev \
      libffi6 \
      libffi-dev \
      supervisor \
      docker \
      python-dev \
      build-essential \
      cron \
      git && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && pip install "certbot==$CERTBOT_VERSION" \
    && pip install "dns-lexicon==$LEXICON_VERSION" \
    && pip install "dns-lexicon[route53]==$LEXICON_VERSION" \
    && pip install "dns-lexicon[softlayer]==$LEXICON_VERSION" \
    && pip install "dns-lexicon[transip]==$LEXICON_VERSION" \
    && pip install "dns-lexicon[dnsmadeeasy]==$LEXICON_VERSION" \
    && mkdir -p /var/lib/letsencrypt/hooks \
    && mkdir -p /etc/supervisord.d

# Copy configuration files
COPY files/run.sh /scripts/run.sh
COPY files/watch-domains.sh /scripts/watch-domains.sh
COPY files/autorestart-containers.sh /scripts/autorestart-containers.sh
COPY files/autocmd-containers.sh /scripts/autocmd-containers.sh
COPY files/crontab /etc/crontab
COPY files/supervisord.conf /etc/supervisord.conf
COPY files/authenticator.sh /var/lib/letsencrypt/hooks/authenticator.sh
COPY files/cleanup.sh /var/lib/letsencrypt/hooks/cleanup.sh
COPY files/deploy-hook.sh /scripts/deploy-hook.sh
COPY files/renew.sh /scripts/renew.sh

RUN chmod +x /scripts/* && \
    chmod +x /var/lib/letsencrypt/hooks/*

VOLUME ["/etc/letsencrypt"]

CMD ["/scripts/run.sh"]
