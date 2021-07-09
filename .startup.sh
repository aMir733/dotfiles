#!/bin/bash

# Kill programs for restarting
killall -q picom
#killall -q srandrd
killall -q dunst
#killall -q polybar

# Run Picom
picom &
# Configure monitors (X11)
srandrd -e screenconfig 
# Run Dunst
dunst &
# Run Polybar
~/.config/polybar/launch.sh
# Wallpaper loading wrong
sleep 2
# Set wallpaper
~/.fehbg 
