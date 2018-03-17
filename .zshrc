# Path to oh-my-zsh installation.
export ZSH=/Users/nickpdemarco/.oh-my-zsh

ZSH_THEME="muse"

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='subl'
fi


# ---
# Functionality
# ---
alias t='tree'
alias c='clear'
alias ls='ls -GFh'
alias profile='vim ~/.zshrc'
alias update_profile='source ~/.zshrc'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'


# ---
# Git Shortcuts
# ---

alias gb='git branch'
alias gs='git status'
alias gac='git add . && git commit -m '
alias gl='git log'
alias push="git push"
alias gc='git checkout '

# ---
# MISCUTIL
# ---
exists () {
	test -e $1 && echo "$1 Exists" || "$1 does not exist"
}

tr () {
	mv $1 ~/.Trash/
}

grab () {
	#     Get the current working directory			Ditch newline  auto-copy
	echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")" | tr '\n' ' ' | pbcopy
}


alias paths="echo $PATH | perl -pe 's/:/\n/g'"
