#!/bin/bash

echo ""
echo "===================================================== INSTALL APPS"
echo ""

./scripts/install.sh

echo ""
echo "===================================================== CONFIGURE SHORTCUTS"
echo ""

./scripts/shortcuts.sh

echo ""
echo "===================================================== ADD CRONJOBS"
echo ""

CRONJOBS="$HOME/crontab_files/cronjobs"
mkdir -p "$HOME/crontab_files"
touch $CRONJOBS

echo "0 0 * * * /sbin/shutdown -h now" >$CRONJOBS
sudo crontab $CRONJOBS

# check status of cron daemon: sudo systemctl status cron
# check system logs: grep shutdown /var/log/syslog

echo ""
