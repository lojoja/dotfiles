# dotfiles/zsh/custom/01shared.zsh
# shellcheck shell=zsh disable=2034

for file in "$DOTFILES_SHARED_SHELL_CUSTOM_PATH"/*".sh"
do
  if [[ -r $file ]]
  then
    # shellcheck disable=1090
    source "$file"
  fi
done
