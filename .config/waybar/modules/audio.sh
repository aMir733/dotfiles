#!/bin/bash

CURRENT=$(wpctl status | sed -n '/^Audio$/,/Sink endpoints:$/p' | sed -n '/\[vol: .*\]/p' | grep '*')
VOLUME=`echo "$(get-volume)*100" | bc | cut -d'.' -f1`

if echo "$CURRENT" | grep -i "HDMI" &>/dev/null ; then
    echo '{"text": "'$VOLUME'", "alt": "hdmi"}' | jq --unbuffered --compact-output
elif echo "$CURRENT" | grep "Wireless" &>/dev/null ; then
    echo '{"text": "'$VOLUME'", "alt": "headphone"}' | jq --unbuffered --compact-output
elif echo "$CURRENT" | grep "Galaxy Buds" &>/dev/null ; then
    # "percentage": '$(buds_battery.py A8:87:B3:01:80:07 | tr ',' '\n' | sort -n | head -n 1 || echo 1)'
    echo '{"text": "'$VOLUME'", "alt": "buds"}' | jq --unbuffered --compact-output
else
    echo '{"text": "'$VOLUME'", "alt": "other"}' | jq --unbuffered --compact-output
fi
