# dotfiles/bash/program/pip.sh

export PIP_CONFIG_FILE="$DOTFILES/pip/pip.conf"
export PIPLOJOJA_VENV_BASE="/usr/local/opt/lojoja"

function piplojoja() {
  local repo_name=$1
  local repo_url="git+https://github.com/lojoja/$repo_name.git@master"
  local venv="$PIPLOJOJA_VENV_BASE/$repo_name"

  /usr/local/bin/virtualenv "$venv" -p /usr/local/bin/python3 --always-copy
  $venv/bin/pip install $repo_url --no-cache-dir --no-binary :all:

  if ! [[ -r "/usr/local/bin/$repo_name" ]]
  then
    ln -s "$venv/bin/$repo_name" "/usr/local/bin/$repo_name"
  fi
}
