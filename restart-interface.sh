#!/bin/ash
# This file is responsible for restarting the network interface.
# Should be run once OFFLINE state is detected.

INTERFACE="wan"

# syslog entry
logger -s "INTERNET KEEP ALIVE SYSTEM: Restarting the Wan interface."

echo "SH RESTART IFACE DOWN"
ifdown $INTERFACE

sleep 2

echo "SH RESTART IFACE UP"
ifup $INTERFACE
