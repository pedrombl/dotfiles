# Path to your oh-my-zsh installation.
export ZSH=/Users/pedroleal/.zplug/repos/robbyrussell/oh-my-zsh

ZSH_THEME="robbyrussell"

ENABLE_CORRECTION="true"

plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

function refresh() {
  source $HOME/.zshrc
}

eval "$(rbenv init -)"

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

setenv('GNUTERM','x11')
export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig

alias bundle='nocorrect bundle'

export EDITOR='vim'
export DISABLE_AUTO_TITLE=true
