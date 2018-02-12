#!/bin/sh

set -e
cp /etc/resolv.conf /var/run/vpnc/resolv.conf-backup
exec /usr/local/sbin/openconnect "$@" $ARGS
