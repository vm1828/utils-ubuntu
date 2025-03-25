#!/bin/bash

CRONJOBS="$HOME/crontab_files/cronjobs"
mkdir -p "$HOME/crontab_files"
touch $CRONJOBS

echo "0 22 * * * /sbin/shutdown -h now" >$CRONJOBS
sudo crontab $CRONJOBS

# check status of cron daemon: sudo systemctl status cron
# check system logs: grep shutdown /var/log/syslog
