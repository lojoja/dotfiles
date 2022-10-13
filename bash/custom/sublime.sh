# dotfiles/bash/custom/sublime.sh
# shellcheck shell=bash

if [[ $HOMEBREW_PREFIX != "" ]]
then
  find '/Applications/Sublime'*'.app/'**'/bin' -type f \( -name 'smerge' -o -name 'subl' \) \
  -exec ln -sf "{}" "$HBBIN" \;
fi
