# dotfiles/bash/program/sublime.sh

if [[ $DOTFILES_INIT_BREW_PREFIX != "" ]]
then
  find '/Applications/Sublime'*'.app/'**'/bin' -type f \( -name 'smerge' -o -name 'subl' \) \
  -exec ln -sf "{}" "${DOTFILES_INIT_BREW_PREFIX}/bin" \;
fi
