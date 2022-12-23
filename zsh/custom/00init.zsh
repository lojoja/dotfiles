# dotfiles/zsh/custom/00init.zsh
# shellcheck shell=zsh

source "$DOTFILES_SHARED_SHELL_INIT_PATH/base.sh"

# Homebrew
export HOMEBREW_NO_ANALYTICS=1

if hash brew &> /dev/null
then
  source "$DOTFILES_SHARED_SHELL_INIT_PATH/homebrew.sh"

  # Update PATH for brew installed programs
  for dir in "$HOMEBREW_PREFIX"/{bin,sbin} "$HBOPT"/*/libtool/gnubin
  do
    path=($dir $path)
  done &>/dev/null

  # Update MANPATH for brew installed programs
  for dir in "$HBSHR"/man "$HBOPT"/*/libtool/gnuman
  do
    manpath=($dir $manpath)
  done &>/dev/null
fi

# Macports
if hash /opt/local/bin/port &> /dev/null
then
  source "$DOTFILES_SHARED_SHELL_INIT_PATH/macports.sh"

  # Update PATH for port installed programs
  for dir in "$MACPORTS_PREFIX"/{bin,sbin} "$MPOPT"/*/{libexec,libtool}/gnubin
  do
    path=($dir $path)
  done &>/dev/null

  # Update MANPATH for port installed programs
  for dir in "$MPSHR"/man "$MPOPT"/{sqlite,ruby}/share/man "$MPOPT"/*/{libexec,libtool}/gnuman
  do
    manpath=($dir $manpath)
  done &>/dev/null

  # ZSH completion
  if [[ -d $MPSHR/zsh-completions ]]
  then
    fpath=($MPSHR/zsh-completions $fpath)
    autoload -Uz compinit
    compinit
  fi
fi

typeset -gU path
