nmcli c modify "$1" "vpn.user-name" "$2"
nmcli c modify "$1" "vpn.secrets" "password=$3"
nmcli c modify "$1" "vpn.data" "`nmcli c show $1 | grep "vpn.data:" | awk -F "                               " '{ print $2 }' | sed "s/password-flags = [0-9]/password-flags = 0/"`"
nmcli c modify "`nmcli c show | grep wifi | awk '{ print $1 }' | head -n 1`" "connection.secondaries" "`nmcli c show | grep "$1" | awk '{ print $2 }'`"
