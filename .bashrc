#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

alias gcl='git clone'
alias gst='git status'
alias gd='git diff'
alias gck='git checkout'
alias gcm='git commit'
alias gcmm='git commit -m'

# GIT_PROMPT_ONLY_IN_REPO=1
# source ~/.bash-git-prompt/gitprompt.sh

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
export WORKON_HOME=$HOME/.virtualenvs

export DJANGO_READ_DOT_ENV_FILE=true
source /usr/bin/virtualenvwrapper.sh

export PATH=$PATH:/usr/lib/llvm/6/bin:$HOME/Projects/Go/bin

export EDITOR="nvim"

PS1='[\W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export BROWSER="google-chrome-stable"
