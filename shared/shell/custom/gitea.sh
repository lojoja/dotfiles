# dotfiles/shared/shell/custom/gitea.sh
# shellcheck shell=bash

export GITEA_PYPI_PACKAGE_REPO_LOJOJA="https://gitea.lojoja.com/api/packages/lojoja/pypi"
export GITEA_PYPI_PACKAGE_REPO_SNLDEV="https://gitea.lojoja.com/api/packages/snldev/pypi"
export GITEA_PYPI_PACKAGE_INDEX_LOJOJA="$GITEA_PYPI_PACKAGE_REPO_LOJOJA/simple"
export GITEA_PYPI_PACKAGE_INDEX_SNLDEV="$GITEA_PYPI_PACKAGE_REPO_SNLDEV/simple"
