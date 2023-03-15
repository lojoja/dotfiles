# dotfiles/shared/shell/custom/xz.sh
# shellcheck shell=bash

threads="$(($(nproc) - 1))"  # Lower thread count to account for default memory limit

export XZ_DEFAULTS='-9 --threads='$threads
export XZ_OPT='-9 --threads='$threads
