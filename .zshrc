# Path to your oh-my-zsh installation.
export ZSH=/Users/nickpdemarco/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="muse"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# User configuration

export PATH="/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# Append the Postgres tools to the path - this may be gross and bad. 
PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ---
# Functionality
# ---
alias t='tree'
alias c='clear'
alias ls='ls -GFh'
alias force_eject='/usr/bin/drutil eject'
alias profile='vim ~/.zshrc'
alias update_profile='source ~/.zshrc'
alias desk='cd ~/Desktop'
alias ..='cd ..'
alias doc='cd ~/Documents'
alias dev='cd ~/Development'

alias graph='cd ~/Development/github/graphscribe/'


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
# Applications
# ---

alias act='open /Applications/Utilities/Activity\ Monitor.app/'
alias chrome='open /Applications/Google\ Chrome.app/'
alias eclipse='open /Applications/Eclipse.app/'
alias safari='open /Applications/Safari.app/'
alias skype='open /Applications/Skype.app/'
alias slack='open /Applications/Slack.app/'
alias sublime='open /Applications/Sublime\ Text\ 2.app/'
alias xcode='open /Applications/Xcode.app/'
alias subl='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'
alias devChrome='open -a "Google Chrome" --args -allow-file-access-from-files'

# ---
# Xcode Repair
# ---
alias clearDerivedData='rm -rf ~/Library/Developer/Xcode/DerivedData'

# ---
# UP
# ---
alias up=". zshup "

# ---
# MISCUTIL
# ---
exists () {
	test -e $1 && echo "File Exists" || "File does not exist"
}

duo () {
	sed $1'q;d' ~/security/DUOcodes
}

tr () {
	mv $1 ~/.Trash/
}

grab () {
	#     Get the current working directory			Ditch newline  auto-copy
	echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")" | tr '\n' ' ' | pbcopy
}


alias paths="echo $PATH | perl -pe 's/:/\n/g'"
alias alert="echo Process Complete | terminal-notifier -sound default -sender com.googlecode.iterm2 -activate com.googlecode.iterm2 -title iTerm2"
