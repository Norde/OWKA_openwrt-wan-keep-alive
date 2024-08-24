#!/bin/ash
# This file is responsible for DNS check. The return value of its process
# determines the ONLINE/OFFLINE state.

IP_TO_PING=9.9.9.9
PACKET_COUNT=5

ONLINE=0

for i in `seq 1 $PACKET_COUNT`;
        do
                nc -G 2 -z $IP_TO_PING 53
                RETVAL=$?
				if [ $RETVAL -eq 0 ]; then
					ONLINE=1
				fi
        done

if [ $ONLINE -eq 1 ]; then
    # ONLINE
    exit 0
else
    # OFFLINE
    exit 1
fi
