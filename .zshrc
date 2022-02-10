autoload -Uz compinit promptinit
compinit
promptinit

prompt redhat

export HISTFILE=$HOME/work/.zsh_history
export HISTSIZE=500000
export SAVEHIST=500000

setopt appendhistory
setopt INC_APPEND_HISTORY  
setopt SHARE_HISTORY

cat /etc/motd
