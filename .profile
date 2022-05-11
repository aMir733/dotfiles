# This will export all the variables that are defined in the next lines
set -a

PATH="/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/local/bin:/usr/bin:/usr/local/games:/usr/games:$HOME/bin:$HOME/.local/bin"
#XDG_DATA_DIRS="$HOME/.local/share:$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"
EDITOR=nvim

XDG_CONFIG_HOME=$HOME/.config
GRIM_DEFAULT_DIR=$HOME/Pictures/screenshots
WOBVOLUMESOCK=$XDG_RUNTIME_DIR/wobvolume.sock
#MOZ_ENABLE_WAYLAND=1

DEF_TERM=alacritty
DEF_EDITOR=nvim
DEF_VPN=uk2031.nordvpn.com.udp

alias c=/bin/cat
alias cat=bat

# No more export
set +a
