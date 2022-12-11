set -a


# -- Enviroment Variables --
PATH="/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/local/bin:/usr/bin:/usr/local/games:/usr/games:$HOME/bin:$HOME/.local/bin"
XDG_DATA_DIRS="$HOME/.local/share:/usr/local/share:/usr/share"
EDITOR=nvim
# -- Enviroment Variables --


# -- Program Variables --
XDG_CONFIG_HOME=$HOME/.config
GRIM_DEFAULT_DIR=$HOME/Pictures/screenshots
WOBVOLUMESOCK=$XDG_RUNTIME_DIR/wobvolume.sock
GIT_ASKPASS=/usr/bin/ksshaskpass
# -- Program Variables --


# -- Default Variables --
DEF_TERM=alacritty
DEF_EDITOR=nvim
DEF_VPN=uk2161.nordvpn.com.udp
DEF_WEB=firefox
# -- Default Variables --


# -- Aliases --
alias c=/bin/cat
alias cat="bat --paging=never --plain"
alias x-copy='xclip -selection clipboard'
# -- Aliases --

set +a
