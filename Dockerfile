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
# remove .sh extension because run-parts wont run scripts with extensions
COPY letsencrypt-cron.sh /etc/periodic/daily/letsencrypt-cron
COPY entrypoint.sh /root/entrypoint.sh

# -----------------------------------------------------------------------------
# Set Volumes
# -----------------------------------------------------------------------------
VOLUME ["/config", "/etc/letsencrypt"]

# -----------------------------------------------------------------------------
# run crond
# -----------------------------------------------------------------------------
# user a wrapper script so when can run something each time the container is started
ENTRYPOINT ["/root/entrypoint.sh"]
