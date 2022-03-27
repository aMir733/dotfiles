#source $HOME/.prof

source $HOME/.profile
export ZSH="$HOME/.oh-my-zsh"

plugins=(zsh-autosuggestions)
DISABLE_MAGIC_FUNCTIONS=true

source $ZSH/oh-my-zsh.sh

PROMPT="%(?:%{$fg_bold[white]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg[yellow]%}%c%{$reset_color%} "
