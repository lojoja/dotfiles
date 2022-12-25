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

if [[ -r /usr/local/bin/brew ]]
then
  source "$DOTFILES_SHARED_SHELL_INIT_PATH/homebrew.sh"

  # Update PATH for brew installed programs
  for dir in "$HOMEBREW_PREFIX"/{bin,sbin} "$HBOPT"/*/libexec/gnubin
  do
    if [[ -d $dir ]]
    then
      PATH="$dir:$PATH"
    fi
  done &>/dev/null

  # Update MANPATH for brew installed programs
  for dir in "$HBSHR"/man "$HBOPT"/*/libexec/gnuman
  do
    if [[ -d $dir ]]
    then
      MANPATH="$dir:$MANPATH"
    fi
  done &>/dev/null

  # Bash completion
  # shellcheck disable=1091
  if [[ -r $HBETC/bash_completion ]]
  then
    source "$HBETC/bash_completion"
  fi
fi

# Macports
if [[ -r /opt/local/bin/port ]]
then
  source "$DOTFILES_SHARED_SHELL_INIT_PATH/macports.sh"

  # Update PATH for port installed programs
  for dir in "$MACPORTS_PREFIX"/{bin,sbin,libexec/gnubin}
  do
    if [[ -d $dir ]]
    then
      PATH="$dir:$PATH"
    fi
  done &>/dev/null

  # Update MANPATH for port installed programs
  for dir in "$MACPORTS_PREFIX"/{man,libexec/gnubin/man}
  do
    if [[ -d $dir ]]
    then
      MANPATH="$dir:$MANPATH"
    fi
  done &>/dev/null

  # Bash completion
  # shellcheck disable=1091
  if [[ -r $MPETC/bash_completion ]]
  then
    source "$MPETC/bash_completion"
  fi
fi
