# dotfiles/bash/custom/01shared.sh
# shellcheck shell=bash disable=2034

for file in "$DOTFILES_SHARED_SHELL_CUSTOM_PATH"/*".sh"
do
  if [[ -r $file ]]
  then
    # shellcheck disable=1090
    source "$file"
  fi
done
