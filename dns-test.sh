#!/bin/sh
# This file is responsible for DNS check. The return value of its process determines the ONLINE (exit 0)/OFFLINE (exit 1) state.
# OpenWRT ncat package is used instead of the included busybox "compact" version or outdated netcat package. 

IP1_TO_SCAN=9.9.9.9 #Quad9 DNS
IP2_TO_SCAN=193.110.81.0 #DNS0.EU
PACKET_COUNT=5

ONLINE1=0
ONLINE2=0

for i in "seq 1 $PACKET_COUNT";
        do
                ncat -G 4 -z $IP1_TO_SCAN 53
                RETVAL1=$?
                if [ $RETVAL1 -eq 0 ]; then
                    ONLINE1=1
                fi
        done

if [ $ONLINE1 -eq 1 ]; then
    # IP1_TO_SCAN is reacheable
    exit 0
fi


for i in "seq 1 $PACKET_COUNT";
        do
                ncat -G 4 -z $IP2_TO_SCAN 53
                RETVAL2=$?
                if [ $RETVAL2 -eq 0 ]; then
                    ONLINE2=1
                fi
        done
if [ $ONLINE2 -eq 1 ]; then
    # IP2_TO_SCAN is reacheable
    exit 0
else
    # OFFLINE (connexion is down)
    exit 1
fi
