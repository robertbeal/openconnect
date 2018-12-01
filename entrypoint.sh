#!/bin/sh

set -e
cp /etc/resolv.conf /var/run/vpnc/resolv.conf-backup

if [ ! -z "$ARGS" ]; 
then
    exec /usr/local/sbin/openconnect $ARGS
else
    exec /usr/local/sbin/openconnect "$@"
fi
