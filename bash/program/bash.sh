# dotfiles/bash/program/bash.sh

completions='/etc/bash_completion'

if [[ $DOTFILES_INIT_HOMEBREW_PREFIX != "" ]]
then
  completions="$DOTFILES_INIT_HOMEBREW_PREFIX/$completions"
fi

if [[ -r $completions ]]
then
  source "$completions"
fi

unset completions
