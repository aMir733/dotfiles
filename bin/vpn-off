#!/usr/bin/env bash


BASENAME="$(basename $0)"
TASK="${BASENAME#*-}"

on() {
    notify-send VPN Connecting
    kdesu -t -- setsid tun2socks-init.sh
}

off() {
    notify-send VPN Disconnecting
    kdesu -t -- pkill -f tun2socks-init.sh
}

case $TASK in
    on) on ;;
    off) off ;;
    *) exit 1 ;;
esac
