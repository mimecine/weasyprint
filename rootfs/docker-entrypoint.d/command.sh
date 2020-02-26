#!/bin/sh

set -e

HOST_DOMAIN="host.docker.internal"
ping -q -c1 $HOST_DOMAIN > /dev/null 2>&1
if [ $? -ne 0 ]; then
  HOST_IP=$(ip route | awk 'NR==1 {print $3}')
  echo -e "$HOST_IP\t$HOST_DOMAIN" >> /etc/hosts
fi
echo -e "$HOST_IP\twp.test" >> /etc/hosts


if [ "${1:0:1}" = '-' ] || [ -f "$1" -a ! -x "$1" ] || [ -n "$(wget -S --spider -O/dev/null "$1" 2>&1 | grep 'HTTP')" ]; then
    set -- weasyprint "$@"
fi
