# dotfiles/bash/custom/00init.sh
# shellcheck shell=bash disable=2034

source "$DOTFILES_SHARED_SHELL_INIT_PATH/base.sh"

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
  source "$DOTFILES_SHARED_SHELL_INIT_PATH/homebrew.sh"

  # Update PATH for brew installed programs
  for dir in "$HOMEBREW_PREFIX"/{bin,sbin} "$HBOPT"/*/libtool/gnubin
  do
    PATH="$dir:$PATH"
  done &>/dev/null

  # Update MANPATH for brew installed programs
  for dir in "$HB_SHR"/man "$HBOPT"/*/libtool/gnuman
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

# Macports
if hash port &> /dev/null
then
  source "$DOTFILES_SHARED_SHELL_INIT_PATH/macports.sh"

  # Update PATH for port installed programs
  for dir in "$MACPORTS_PREFIX"/{bin,sbin} "$MPOPT"/*/{libexec,libtool}/gnubin
  do
    PATH="$dir:$PATH"
  done &>/dev/null

  # Update MANPATH for port installed programs
  for dir in "$MPSHR"/man "$MPOPT"/{sqlite,ruby}/share/man "$MPOPT"/*/{libexec,libtool}/gnuman
  do
    MANPATH="$dir:$MANPATH"
  done &>/dev/null

  # Bash completion
  # shellcheck disable=1091
  if [[ -r $MPETC/bash_completion ]]
  then
    source "$MPETC/bash_completion"
  fi
fi
