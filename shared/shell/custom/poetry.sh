# dotfiles/shared/shell/custom/poetry.sh
# shellcheck shell=bash

if hash poetry &>/dev/null
then
  export POETRY_CACHE_DIR="$HOME/Library/Caches/pypoetry"
  export POETRY_CONFIG_DIR="$DOTFILES_INSTALLED_CONFIG_PATH/poetry"
  export POETRY_CONFIG_FILE="$POETRY_CONFIG_DIR/config.toml"
  export POETRY_REPOSITORIES_LOJOJA_URL="https://gitea.lojoja.com/api/packages/lojoja/pypi"
  export POETRY_REPOSITORIES_SNLDEV_URL="https://gitea.lojoja.com/api/packages/snldev/pypi"
  export POETRY_CERTIFICATES_LOJOJA_CERT="$DOTFILES_SHARED_PATH/lojojaCerts.pem"
  export POETRY_CERTIFICATES_SNLDEV_CERT="$DOTFILES_SHARED_PATH/lojojaCerts.pem"
fi
