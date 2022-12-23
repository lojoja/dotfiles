# dotfiles/shared/shell/init/base.sh
# shellcheck shell=bash

# BASIC CONFIG
export EDITOR='nano'
export IGNOREEOF=1
export LC_ALL=en_US.utf-8
export TERM=xterm-256color
export VISUAL="$EDITOR"

# macOS
export ARCHFLAGS="-arch x86_64 -arch i386"
export CLICOLOR=1
export COPYFILE_DISABLE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
