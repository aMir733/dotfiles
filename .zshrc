source $HOME/.prof
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	startx
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(zsh-autosuggestions)

DISABLE_MAGIC_FUNCTIONS=true
source $ZSH/oh-my-zsh.sh
