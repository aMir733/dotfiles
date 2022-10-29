source $HOME/.profile
ZSH="$HOME/.oh-my-zsh"

plugins=(zsh-autosuggestions dirhistory git)
ZSH_THEME=robbyrussell-fork
DISABLE_MAGIC_FUNCTIONS=true
DISABLE_AUTO_UPDATE="true"

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
