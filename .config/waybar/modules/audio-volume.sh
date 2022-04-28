#!/bin/bash

VOLUME=`echo "$(get-volume)*100" | bc | cut -d'.' -f1`
echo '{"percentage": '$VOLUME'}' | jq --unbuffered --compact-output
