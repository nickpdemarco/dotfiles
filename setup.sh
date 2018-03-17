#!/bin/bash

report() {
	size=$(($(tput cols) - ${#1} - 2))
	head -c $((size / 2)) < /dev/zero | tr '\0' '-' 
	echo -n " "
	echo -n $1
	echo -n " "
	head -c $((size / 2)) < /dev/zero | tr '\0' '-' 
	echo
}

which -s brew
if [[ $? != 0 ]] ; then
    report "Installing brew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    report "Updating brew"
    brew update
fi

brew install tree
brew install the_silver_searcher

report "Installing Google Chrome"
brew cask install google-chrome
report "Installing Sublime"
brew cask install sublime-text
report "Installing iTerm 2"
brew cask install iterm2

report "Make the dock only show active apps"
defaults write com.apple.dock static-only -bool TRUE; killall Dock

report "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

report "Install my .zshrc"
curl https://raw.githubusercontent.com/nickpdemarco/dotfiles/master/.zshrc > ~/.zshrc

report "Default to /bin/zsh"
chsh -s /bin/zsh
