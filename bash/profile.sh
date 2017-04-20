# dotfiles/bash/profile.sh

# INIT
export DOTFILES="$HOME/.dotfiles"
DOTFILES_INIT_DIRCOLORS="$DOTFILES/bash/program/ls.colors"
DOTFILES_INIT_MAC=0
DOTFILES_INIT_BREW_PREFIX=""

# PATHS
source "$DOTFILES/bash/path.sh"
source "$DOTFILES/bash/manpath.sh"

# OS-SPECIFIC
if [[ `uname -s` -eq 'Darwin' ]]
then
  DOTFILES_INIT_MAC=1

  if hash brew &>/dev/null
  then
    DOTFILES_INIT_BREW_PREFIX="`brew --prefix`"
  fi

  export EDITOR='subl -n -w'
  export COPYFILE_DISABLE=true
  export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
else
  export EDITOR='nano'
fi

# GENERAL
export ARCHFLAGS="-arch i386 -arch x86_64"
export CLICOLOR=1
export IGNOREEOF=1
export LC_ALL=en_US.utf-8
export LC_CTYPE=en_US.utf-8
export SHELL_SESSION_HISTORY=0
export TERM=xterm-256color
export VISUAL="$EDITOR"
shopt -s histappend

# CONSTANTS
source "$DOTFILES/bash/constant.sh"

# PROGRAM CONFIGURATION
for f in $DOTFILES/bash/program/*.sh
do
  source "$f"
done

# PRIVATE VARIABLES
if [[ -r "$DOTFILES/bash/private.sh" ]]
then
  source "$DOTFILES/bash/private.sh"
fi

# PROMPT
source "$DOTFILES/bash/prompt.sh"

# CLEANUP
unset DOTFILES_INIT_BREW_PREFIX
unset DOTFILES_INIT_DIRCOLORS
unset DOTFILES_INIT_MAC

# LOCAL SETTINGS
if [[ -r "$DOTFILES/bash/local.sh" ]]
then
  source "$DOTFILES/bash/local.sh"
fi
