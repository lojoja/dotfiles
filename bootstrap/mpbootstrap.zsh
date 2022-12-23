#!/usr/bin/env zsh

# Core utilities
yes | sudo port install coreutils curl findutils gsed gnutar grep gzip less p7zip ripgrep wget xz

# Shell
yes | sudo port install bash bash-completion zsh zsh-autosuggestions zsh-completions 

# Version Control
yes | sudo port install git subversion

# Document formats
yes | sudo port install libsass libxml2 libyaml

# Javascript
yes | sudo port install nodejs19 yarn

# PHP
yes | sudo port install php81 -libedit +readline php81-pcov php81-curl php81-mbstring php81-mysql php81-openssl php81-posix php81-sodium php81-sqlite
yes | sudo port install php82 -libedit +readline php82-pcov php82-curl php82-mbstring php82-mysql php82-openssl php82-posix php82-sodium php82-sqlite
sudo port select --set php php82

# Python
yes | sudo port install python38 python39 python310 poetry 
sudo port select --set python3 python310
sudo port select --set virtualenv virtualenv310

# Ruby
yes | sudo port install ruby
sudo port select --set ruby ruby18

# Automation
yes | sudo port install py-ansible
sudo port select --set ansible py310-ansible

# Database
yes | sudo port install mysql8-server sqlite3
sudo port select mysql mysql8

# Media 
yes | sudo port install exiftool exiv2 ffmpeg guetzli imagemagick lame libpng optipng youtube-dl yt-dlp

# Misc utils 
yes | sudo port install fzf mailhog py-pygments pv shellcheck starship thefuck watch
sudo port select --set pygments py310-pygments
