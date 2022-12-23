# dotfiles/shared/shell/init/homebrew.sh
# shellcheck shell=bash

# Homebrew envvars (official)
HOMEBREW_PREFIX="$(brew --prefix)"
HOMEBREW_CELLAR="$(brew --cellar)"
HOMEBREW_REPOSITORY="$(brew --repository)"
export HOMEBREW_PREFIX
export HOMEBREW_CELLAR
export HOMEBREW_REPOSITORY

# Homebrew helper envvars (unofficial, don't use "HOMEBREW_" prefix)
HBBIN=$HOMEBREW_PREFIX/bin
HBETC=$HOMEBREW_PREFIX/etc
HBLIB=$HOMEBREW_PREFIX/lib
HBOPT=$HOMEBREW_PREFIX/opt
HBSHR=$HOMEBREW_PREFIX/share
