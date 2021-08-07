killall -q picom
killall -q dunst
#killall -q polybar # Polybar is killed in the launch script so no need to kill it here

# Run Picom
picom &

# Configure monitors (X11)
#autorandr -c

# Run Dunst
dunst &

# Run Polybar
~/.config/polybar/launch.sh
sleep 2

# Set wallpaper
~/.fehbg 
