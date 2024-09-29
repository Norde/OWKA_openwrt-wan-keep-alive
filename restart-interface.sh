#!/bin/ash
# This file is responsible for restarting all network interfaces.
# Should be run once OFFLINE state is detected.

# syslog entry
logger -s "OpenWRT Wan keep alive: Restarting all nerwork interfaces (wan, lan and wifi)"

echo "Restarting network interfaces"
service network restart
