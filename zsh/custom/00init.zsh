# dotfiles/zsh/custom/00init.zsh
# shellcheck shell=zsh

# BASIC CONFIG
export EDITOR="nano"
export IGNOREEOF=1
export LC_ALL=en_US.utf-8
export TERM=xterm-256color
export VISUAL="$EDITOR"

# macOS
export ARCHFLAGS="-arch x86_64 -arch i386"
export CLICOLOR=1
export COPYFILE_DISABLE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true

# Homebrew
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
    path=($dir $path)
  done &>/dev/null

  # Update MANPATH for brew installed programs
  for dir in "$HOMEBREW_PREFIX"/share/man "$HBOPT"/{sqlite,ruby}/share/man "$HBOPT"/*/libexec/gnuman
  do
    manpath=($dir $manpath)
  done &>/dev/null

  # ZSH completion
  if [[ -d $HBSHR/zsh-completions ]]
  then
    fpath=($HBSHR/zsh-completions $fpath)
    #FPATH="$HBSHR/zsh-completions:$FPATH"
    autoload -Uz compinit
    compinit
  fi
fi

typeset -gU path
