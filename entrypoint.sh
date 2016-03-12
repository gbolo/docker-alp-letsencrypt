#!/bin/bash

# on container start, lets scan user configs
/etc/periodic/daily/letsencrypt-cron.sh -c

# now lets just start crond in foreground
/usr/sbin/crond -f -l 0
