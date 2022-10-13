# dotfiles/bash/custom/00init.sh
# shellcheck shell=bash disable=2034

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

# SHELL
shopt -s nocaseglob
shopt -s cdspell
shopt -s checkwinsize

export SHELL_SESSION_HISTORY=0
export BASH_SILENCE_DEPRECATION_WARNING=1

export HISTCONTROL='ignoredups:erasedups'
export HISTTIMEFORMAT='[%F %T] '
export HISTSIZE=999999
export HISTFILESIZE=$HISTSIZE;
export HISTIGNORE='..:...:....:--:cd:cd..:ls:lsa:lsd:ll:lla:lld:pwd:exit:date:history'

shopt -s histappend
shopt -s histreedit
shopt -s histverify

for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null;
done;

# HOMEBREW
export HOMEBREW_NO_ANALYTICS=1

if hash brew &> /dev/null
then
  # Homebrew envvars (official)
  HOMEBREW_PREFIX="$(brew --prefix)"
  HOMEBREW_CELLAR="$(brew --cellar)"
  HOMEBREW_REPOSITORY="$(brew --repository)"
  export HOMEBREW_PREFIX
  export HOMEBREW_CELLAR
  export HOMEBREW_REPOSITORY

  # Homebrew helper envvars (unofficial, don't use "HOMEBREW_" prefix)
  export HBBIN=$HOMEBREW_PREFIX/bin
  export HBETC=$HOMEBREW_PREFIX/etc
  export HBLIB=$HOMEBREW_PREFIX/lib
  export HBOPT=$HOMEBREW_PREFIX/opt
  export HBSHR=$HOMEBREW_PREFIX/share

  # Update PATH for brew installed programs
  for dir in "$HOMEBREW_PREFIX"/{bin,sbin} "$HBOPT"/{sqlite,ruby}/bin "$HBOPT"/*/libexec/gnubin
  do
    PATH="$dir:$PATH"
  done &>/dev/null

  # Update MANPATH for brew installed programs
  for dir in "$HOMEBREW_PREFIX"/share/man "$HBOPT"/{sqlite,ruby}/share/man "$HBOPT"/*/libexec/gnuman
  do
    MANPATH="$dir:$MANPATH"
  done &>/dev/null

  # Bash completion
  # shellcheck disable=1091
  if [[ -r $HBETC/bash_completion ]]
  then
    source "$HBETC/bash_completion"
  fi
fi

# COLOR CONSTANTS
RESET="\e[0m"
BLACK="\e[0;30m"
BLACK_BOLD="\e[1;30m"
BLACK_BOLD_UL="\e[1;4;30m"
BLACK_UL="\e[4;30m"
RED="\e[0;31m"
RED_BOLD="\e[1;31m"
RED_BOLD_UL="\e[1;4;31m"
RED_UL="\e[4;31m"
GREEN="\e[0;32m"
GREEN_BOLD="\e[1;32m"
GREEN_BOLD_UL="\e[1;4;32m"
GREEN_UL="\e[4;32m"
YELLOW="\e[0;33m"
YELLOW_BOLD="\e[1;33m"
YELLOW_BOLD_UL="\e[1;4;33m"
YELLOW_UL="\e[4;33m"
BLUE="\e[0;34m"
BLUE_BOLD="\e[1;34m"
BLUE_BOLD_UL="\e[1;4;34m"
BLUE_UL="\e[4;34m"
MAGENTA="\e[0;35m"
MAGENTA_BOLD="\e[1;35m"
MAGENTA_BOLD_UL="\e[1;4;35m"
MAGENTA_UL="\e[4;35m"
CYAN="\e[0;36m"
CYAN_BOLD="\e[1;36m"
CYAN_BOLD_UL="\e[1;4;36m"
CYAN_UL="\e[4;36m"
WHITE="\e[0;37m"
WHITE_BOLD="\e[1;37m"
WHITE_BOLD_UL="\e[1;4;37m"
WHITE_UL="\e[4;37m"
