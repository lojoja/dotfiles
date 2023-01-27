# dotfiles/shared/shell/custom/zzUtil.sh
# shellcheck shell=bash

function utilAdd() {
  # Install private cli utils by passing "<owner>/<package>" arguments to this function.

  local args=("${@}")
  local python="$MPBIN/python3.10"
  local package
  local venv
  local venv_bin
  local pip
  local file
  local re

  for arg in "${args[@]}"
  do
    package="$arg"
    venv="$HBOPT/util/$package"
    venv_bin="$venv/bin"
    pip="$venv_bin/pip"

    if [[ ! -d $venv ]]
    then
      printf "Creating virtualenv\n"
      "$python" -m venv "$venv"
    fi

    $pip install pip --upgrade

    if [[ -f $venv_bin/$package ]]
    then
      printf "Upgrading %s\n" "$package"
      $pip install $package --upgrade --extra-index-url=$GITEA_PYPI_PACKAGE_INDEX_LOJOJA --extra-index-url=$GITEA_PYPI_PACKAGE_INDEX_SNLDEV
    else
      printf "Installing %s\n" "$package"
      $pip install $package --extra-index-url=$GITEA_PYPI_PACKAGE_INDEX_LOJOJA --extra-index-url=$GITEA_PYPI_PACKAGE_INDEX_SNLDEV
    fi

    for file_path in "$venv_bin"/*
    do
      file=$(basename "$file_path")
      re="^([Aa]ctivate|pip|python).*"

      if [[ ! $file =~ $re ]]
      then
        ln -sf "$venv_bin/$file" "$HBBIN/$file"
      fi
    done
  done
}

function utilDel() {
  # Uninstall private cli utils by passing one or more utility names to this function.

  local args=("${@}")
  local venv
  local venv_bin
  local file
  local re

  for arg in "${args[@]}"
  do
    venv="$HBOPT/util/$arg"
    venv_bin="$venv/bin"

    if [[ -d $venv ]]
    then
      printf "Uninstalling %s\n" "$arg"

      for file_path in "$venv_bin"/*
      do
        file=$(basename "$file_path")
        re="([Aa]ctivate|pip|python).*"

        if [[ ! $file =~ $re ]]
        then
          rm -f "$HBBIN/$file"
        fi
      done

      rm -rf "$venv"
    else
      printf "Error: Unknown util %s\n" "$arg"
    fi
  done
}
