#!/bin/bash

# on container start, lets scan user configs
/etc/periodic/daily/letsencrypt-cron -c

# now lets just start crond in foreground with max verbose
/usr/sbin/crond -f -l 0
