#!/bin/bash
CURRENT=$(wpctl status | sed -n '/^Audio$/,/Sink endpoints:$/p' | sed -n '/\[vol: .*\]/p' | grep '*')
if echo "$CURRENT" | grep "Navi 21 HDMI" &>/dev/null ; then
    echo '{"text": "hdmi", "alt": "hdmi"}' | jq --unbuffered --compact-output
elif echo "$CURRENT" | grep "Wireless" &>/dev/null ; then
    echo '{"text": "headphone", "alt": "headphone"}' | jq --unbuffered --compact-output
elif echo "$CURRENT" | grep "Galaxy Buds" &>/dev/null ; then
    echo '{"text": "buds", "percentage": '$(buds_battery.py A8:87:B3:01:80:07 | tr ',' '\n' | sort -n | head -n 1 || echo 1)'}' | jq --unbuffered --compact-output
fi
