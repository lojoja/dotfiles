# dotfiles/zsh/custom/poetry.zsh
# shellcheck shell=zsh

if hash poetry &>/dev/null
then
  export POETRY_CACHE_DIR="$HOME/Library/Caches/pypoetry"
  export POETRY_CONFIG_DIR="$HOME/.config/poetry"
  export POETRY_CONFIG_FILE="$POETRY_CONFIG_DIR/config.toml"
fi
