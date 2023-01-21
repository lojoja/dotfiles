# dotfiles/shared/shell/custom/zzUtil.sh
# shellcheck shell=bash

function utilAdd() {
  # Install private cli utils by passing "<owner>/<package>" arguments to this function.

  local args=("${@}")
  local python="$MPBIN/python3.10"
  local owner
  local package
  local venv
  local venv_bin
  local pip
  local pip_args
  local index
  local file
  local re

  for arg in "${args[@]}"
  do
    owner="${arg%/*}"
    package="${arg#*/}"
    venv="$HBOPT/util/$package"
    venv_bin="$venv/bin"
    pip="$venv_bin/pip"

    if [[ $owner = 'lojoja' ]]
    then
      index="$GITEA_PYPI_PACKAGE_INDEX_LOJOJA"
    elif [[ $owner = 'snldev' ]]
      then
        index="$GITEA_PYPI_PACKAGE_INDEX_SNLDEV"
    else
      printf "Error: Unknown user %s\n" "$owner" && return 1
    fi

    pip_args="--extra-index-url=$index"
    package_args="$package"

    if [[ ! -d $venv ]]
    then
      printf "Installing %s\n" "$package"
      "$python" -m venv "$venv"
    else
      printf "Upgrading %s\n" "$package"
      package_args="$package_args --upgrade"
    fi

    "$pip" install --upgrade pip
    "$pip" install "$pip_args" "$package_args"

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
