# dotfiles/shared/shell/custom/poetry.sh
# shellcheck shell=bash

if hash poetry &>/dev/null
then
  export POETRY_CACHE_DIR="$HOME/Library/Caches/pypoetry"
  export POETRY_CONFIG_DIR="$DOTFILES_INSTALLED_CONFIG_PATH/poetry"
  export POETRY_CONFIG_FILE="$POETRY_CONFIG_DIR/config.toml"
fi
