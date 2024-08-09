#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# xkb options
ibus restart
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape', 'compose:rctrl']"

sudo apt install -y ack ccrypt dos2unix silversearcher-ag tree htop
sudo apt install -y gimp inkscape dconf-editor
sudo snap install dust

# Wez's Terminal Emulator
if command -v wezterm &>/dev/null; then
  echo "Wez's Terminal Emulator is installed."
else
  curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
  echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
  sudo apt update
  sudo apt install wezterm
fi

cat <<"EOF" >~/.wezterm.lua
-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Tokyo Night'

-- and finally, return the configuration to wezterm
return config
EOF

# Bash extras
if command -v starship &>/dev/null; then
  echo "Starship is installed."
else
  curl -sS https://starship.rs/install.sh | sh
  echo 'set -o vi' >>~/.bashrc
  echo 'eval "$(starship init bash)"' >>~/.bashrc
fi

# zsh
if command -v zsh &>/dev/null; then
  echo "Zsh is installed."
else
  sudo apt install -y zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  sudo chsh -s /usr/bin/zsh
fi

cat <<"EOF" >~/.zshrc
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 13

plugins=(git vi-mode zsh-interactive-cd)

source $ZSH/oh-my-zsh.sh

alias vim=nvim
alias view="nvim -R";
alias vimdiff="nvim -d";

alias ll='eza -lh --group-directories-first --icons'
alias lla='ll -a'
alias llt='eza --tree --level=2 --long --icons --git'

alias cdb="cd $HOME/code/ruby/Bitcoin-Top-Club";
alias cdc="cd $HOME/code/leetcode/clojure/solutions";
alias cdg="cd $HOME/code/ruby/Web3-Game";
alias cdr="cd $HOME/code/leetcode/solution_template";

if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi
EOF

# .gitconfig
cat <<EOF >~/.gitconfig
[user]
	name = Andrew Nagi
	email = andrew.nagi@gmail.com
[alias]
	aa = add --all
	amend = ci --amend
	b = branch
	ba = branch -a
	ci = commit -v
	co = checkout
	dc = diff --cached
	di = diff
	me = "!git log --pretty=format:\"%h%x09%an%x09%ad%x09%s\" | grep -i nagi | less"
	la = !git l --all
	pom = push origin master
	phm = push heroku master
	r = remote
	rv = remote -v
	rm="!git ls-files --deleted | xargs git rm"
	st = status
[color]
	ui = true
[core]
	editor = nvim
	autocrlf = input
	excludesfile = ~/.gitignore_global
[merge]
	tool = "nvim -d"
[init]
	defaultBranch = main
EOF

# .gitignore_global
cat <<EOF >~/.gitignore_global
# https://github.com/github/gitignore

# MacOS
#######

*.DS_Store
.AppleDouble
.LSOverride

# Icon must end with two \r
Icon


# Thumbnails
._*

# Files that might appear in the root of a volume
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent

# Directories potentially created on remote AFP share
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk

# Emacs
#######

# -*- mode: gitignore; -*-
*~
\#*\#
/.emacs.desktop
/.emacs.desktop.lock
*.elc
auto-save-list
tramp
.\#*

# Org-mode
.org-id-locations
*_archive

# flymake-mode
*_flymake.*

# eshell files
/eshell/history
/eshell/lastdir

# elpa packages
/elpa/

# reftex files
*.rel

# AUCTeX auto folder
/auto/

# cask packages
.cask/
dist/

# Flycheck
flycheck_*.el

# projectiles files
.projectile

# directory configuration
.dir-locals.el
Contact GitHub API Training Shop Blog About

# VIM
#####

# swap
[._]*.s[a-v][a-z]
[._]*.sw[a-p]
[._]s[a-v][a-z]
[._]sw[a-p]
# session
Session.vim
# temporary
.netrwhist
*~
# auto-generated tag files
tags
EOF
