# Path to your oh-my-zsh installation.
export ZSH=/Users/pedroleal/.zplug/repos/robbyrussell/oh-my-zsh

ZSH_THEME="gitster"
ENABLE_CORRECTION="true"

plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source ~/.private.sh

function refresh() {
  source $HOME/.zshrc
}

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

setenv('GNUTERM','x11')
export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig

unsetopt correct_all
#alias bundle='nocorrect bundle'
alias be='bundle exec'
alias tags='./.git/hooks/ctags'
alias noise='terminal-notifier -message DONE -sound default'
alias base='tmux attach -t base || tmux new -s base'
unsetopt nomatch

export EDITOR='vim'
export DISABLE_AUTO_TITLE=true
export GOPATH=$HOME/.go_work
export PATH=$PATH:$GOPATH/bin:/usr/local/opt/go/libexec/bin
export PATH=$PATH:/Users/pedroleal/Library/Python/3.5/bin
export PATH=$PATH:/Users/pedroleal/Workspace/productivity
export PATH=$PATH:/Users/pedroleal/Workspace/learning-python/giphy

alias redflags='tag -m Red'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


function clean_branches() {
  git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}

source ~/.tmuxinator.zsh

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(direnv hook zsh)"
