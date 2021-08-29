#!/bin/bash

case $1 in
	togpause)
		echo '{"command": ["cycle", "pause"]}' | socat - ~/tmp/mpvsocket
		exit
		;;
	back)
		echo '{"command": ["seek", "-4"]}' | socat - ~/tmp/mpvsocket
		exit
		;;
	forward)
		echo '{"command": ["seek", "4"]}' | socat - ~/tmp/mpvsocket
		exit
		;;
	*)
		echo "Read the script i don't have time for a help message"
		exit
		;;
esac
