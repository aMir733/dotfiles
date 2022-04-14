# This will export all the variables that are defined in the next lines
set -a

PATH="/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/local/bin:/usr/bin:/usr/local/games:/usr/games:$HOME/bin:$HOME/.local/bin"
XDG_DATA_DIRS="$HOME/.local/share:$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"
EDITOR=nvim

XDG_CONFIG_HOME=$HOME/.config
XDG_CURRENT_DESKTOP=Unity

DEF_TERM=alacritty
DEF_EDITOR=nvim
DEF_VPN=uk2031.nordvpn.com.udp

# No more export
set +a
