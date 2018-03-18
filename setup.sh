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

brew_check_install() {
	if brew ls --versions $1 > /dev/null; then
	  report "$1 already installed"
	else
	  report "Installing $1"
	  brew install $1
	fi
}

brew_cask_check_install() {
	if brew cask ls --versions $1 > /dev/null; then
	  report "$1 already installed"
	else
	  report "Installing $1"
	  brew cask install $1
	fi
}

which -s brew
if [[ $? != 0 ]] ; then
    report "Installing brew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    report "Updating brew"
    brew update
fi

brew_check_install tree
brew_check_install the_silver_searcher

brew_cask_check_install google-chrome
brew_cask_check_install sublime-text
brew_cask_check_install iterm2
brew_cask_check_install spectacle
brew_cask_check_install unity

if [ "$(defaults read com.apple.dock static-only)" != "1" ]; then
	report "Make the dock only show active apps"
	defaults write com.apple.dock static-only -bool TRUE; killall Dock
fi

if [ "$(defaults read NSGlobalDomain AppleKeyboardUIMode)" != "3" ]; then
	report "Enable tabbing between UI elements"
	defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
fi


if [ "$SHELL" == "/bin/zsh" ]; then
  report "ZSH already configured"
else
	report "Install oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	report "Install my .zshrc"
	curl https://raw.githubusercontent.com/nickpdemarco/dotfiles/master/.zshrc > ~/.zshrc
fi
