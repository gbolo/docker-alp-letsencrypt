FROM alpine:latest

MAINTAINER George Bolo <gbolo@linuxctl.com>

EXPOSE 80

# -----------------------------------------------------------------------------
# Install our dependancies
# -----------------------------------------------------------------------------
RUN apk add --no-cache \
    python python-dev py-pip \
    gcc musl-dev linux-headers \
    augeas-dev openssl-dev libffi-dev ca-certificates dialog \

# -----------------------------------------------------------------------------
# Install letsencrypt client through pip
# -----------------------------------------------------------------------------
RUN pip install -U letsencrypt

# -----------------------------------------------------------------------------
# Prepare and configure
# -----------------------------------------------------------------------------
COPY letsencrypt-cron.sh /etc/periodic/daily/letsencrypt-cron.sh

# -----------------------------------------------------------------------------
# Set Volumes
# -----------------------------------------------------------------------------
VOLUME ["/config", "/etc/letsencrypt"]

# -----------------------------------------------------------------------------
# run crond
# -----------------------------------------------------------------------------
CMD ["/usr/bin/crond"]
