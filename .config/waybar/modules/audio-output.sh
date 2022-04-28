#!/bin/bash

CURRENT=$(wpctl status | sed -n '/^Audio$/,/Sink endpoints:$/p' | sed -n '/\[vol: .*\]/p' | grep '*')
check_current () { if echo "$CURRENT" | grep -i "$1" &>/dev/null ; then echo true ; fi ; }

case true in
    "$(check_current "HDMI")") echo '{"text": "HDMI", "alt": "hdmi"}' | jq --unbuffered --compact-output ;;
    "$(check_current "Wireless")") echo '{"text": "Headphone", "alt": "headphone"}' | jq --unbuffered --compact-output ;;
    "$(check_current "Galaxy buds")") echo '{"text": "Galaxy Buds", "alt": "buds"}' | jq --unbuffered --compact-output ;;
    *) echo '{"text": "??", "alt": "others"}' | jq --unbuffered --compact-output ;;
esac
