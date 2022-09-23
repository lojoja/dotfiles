# dotfiles/bash/program/poetry.sh

if hash poetry &>/dev/null
then
  export POETRY_CONFIG_DIR="$HOME/.config/poetry"
  export POETRY_CONFIG_FILE="$POETRY_CONFIG_DIR/config.toml"
fi