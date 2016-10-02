FROM alpine:edge

MAINTAINER George Bolo <gbolo@linuxctl.com>

EXPOSE 80

# -----------------------------------------------------------------------------
# Install our dependancies
# -----------------------------------------------------------------------------
RUN apk add --no-cache \
    bash python certbot

# -----------------------------------------------------------------------------
# Prepare and configure
# -----------------------------------------------------------------------------
COPY letsencrypt-cron.sh /etc/periodic/daily/letsencrypt-cron.sh
COPY entrypoint.sh /root/entrypoint.sh

# -----------------------------------------------------------------------------
# Set Volumes
# -----------------------------------------------------------------------------
VOLUME ["/config", "/etc/letsencrypt"]

# -----------------------------------------------------------------------------
# run crond
# -----------------------------------------------------------------------------
#CMD ["/usr/sbin/crond"]
ENTRYPOINT ["/root/entrypoint.sh"]
