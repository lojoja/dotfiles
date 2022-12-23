# dotfiles/shared/shell/init/macports.sh
# shellcheck shell=bash

# Macports envvars
MACPORTS_PREFIX="/opt/local"
export MACPORTS_PREFIX

# Macport helper envvars
MPBIN=$MACPORTS_PREFIX/bin
MPETC=$MACPORTS_PREFIX/etc
MPLIB=$MACPORTS_PREFIX/lib
MPOPT=$MACPORTS_PREFIX/opt
MPSHR=$MACPORTS_PREFIX/share
