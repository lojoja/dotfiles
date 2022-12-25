# dotfiles/zsh/custom/00init.zsh
# shellcheck shell=zsh disable=1009,1036,1058,1072,1073

source "$DOTFILES_SHARED_SHELL_INIT_PATH/base.sh"

# Homebrew
export HOMEBREW_NO_ANALYTICS=1

if hash brew &> /dev/null
then
  source "$DOTFILES_SHARED_SHELL_INIT_PATH/homebrew.sh"

  # Update PATH for brew installed programs
  for dir in "$HOMEBREW_PREFIX"/{bin,sbin} "$HBOPT"/*/libexec/gnubin(N)
  do
    if [[ -d $dir ]]
    then
      path=($dir $path)
    fi
  done &>/dev/null

  # Update MANPATH for brew installed programs
  for dir in "$HBSHR"/man "$HBOPT"/*/libexec/gnuman(N)
  do
    if [[ -d $dir ]]
    then
      manpath=($dir $manpath)
    fi
  done &>/dev/null
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
      path=($dir $path)
    fi
  done &>/dev/null

  # Update MANPATH for port installed programs
  for dir in "$MACPORTS_PREFIX"/{man,libexec/gnubin/man}
  do
    if [[ -d $dir ]]
    then
      manpath=($dir $manpath)
    fi
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
