# dotfiles/bash/rc.sh
# shellcheck shell=bash

# Dotfiles
# NB: bash custom files are loaded from this rc file manually, but the paths
# are defined here for consistency with the oh-my-zsh configuration which
# loads the custom files automatically requiring the paths to be defined early.

# dotfiles install directory
export DOTFILES="$HOME/.dotfiles"
DOTFILES_BASH_PATH="$DOTFILES/bash"
DOTFILES_BASH_CUSTOM_PATH="$DOTFILES_BASH_PATH/custom"
DOTFILES_BASH_PROMPT="$DOTFILES_BASH_PATH/prompt.sh"
DOTFILES_INSTALLED_CONFIG_PATH="$HOME/.config"
DOTFILES_SHARED_PATH="$DOTFILES/shared"
DOTFILES_SHARED_SHELL_PATH="$DOTFILES_SHARED_PATH/shell"
DOTFILES_SHARED_SHELL_CUSTOM_PATH="$DOTFILES_SHARED_SHELL_PATH/custom"
DOTFILES_SHARED_SHELL_INIT_PATH="$DOTFILES_SHARED_SHELL_PATH/init"

# Export paths to editable files for convenience
export DOTFILES_PRIVATE="$DOTFILES_SHARED_SHELL_PATH/private.sh"
export DOTFILES_LOCAL="$DOTFILES_SHARED_SHELL_PATH/local.sh"

# Load configuration files
# The files are loaded in the following order
#   - $DOTFILES_CUSTOM/*.sh [alphabetically]
#   - $DOTFILES_BASH_PROMPT
#   - $DOTFILES_PRIVATE
#   - $DOTFILES_LOCAL
for file in "$DOTFILES_BASH_CUSTOM_PATH"/*".sh" "$DOTFILES_BASH_PROMPT" "$DOTFILES_PRIVATE" "$DOTFILES_LOCAL"
do
  if [[ -r $file ]]
  then
    # shellcheck disable=1090
    source "$file"
  fi
done
