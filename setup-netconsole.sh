#!/usr/bin/env sh

set -e

if [ -f /etc/default/netconsole ]; then
    . /etc/default/netconsole
else
    exit 1
fi

SETTING_PREFIX="/sys/kernel/config/netconsole/$HOST"
if ! mkdir --parents "$SETTING_PREFIX"; then
    echo "Error creating dir \"$SETTING_PREFIX\"."
    exit 1
fi

# disable before updating
if [ `cat $SETTING_PREFIX/enabled` -eq 1 ]; then
    echo 0 > "$SETTING_PREFIX/enabled"
fi

echo "$IFACE" > "$SETTING_PREFIX/dev_name"
echo "$SRC_IP" > "$SETTING_PREFIX/local_ip"
echo "$SRC_PORT" > "$SETTING_PREFIX/local_port"

echo "$DST_IP" > "$SETTING_PREFIX/remote_ip"
echo "$DST_PORT" > "$SETTING_PREFIX/remote_port"
echo "$DST_MAC" > "$SETTING_PREFIX/remote_mac"

echo 1 > "$SETTING_PREFIX/enabled"

