# dotfiles/bash/program/firefox.sh

if [[ $DOTFILES_INIT_MAC -eq 1 ]]
then
  FIREFOX_APP='/Applications/Firefox.app/Contents/MacOS/firefox'

  if [[ -r $FIREFOX_APP ]]
  then
    # Array of profile names
    #
    # Profiles can be defined in dotfiles/bash/local.sh.
    # The friendly profile name is the key and the internal profile name is the value, e.g.,:
    # FIREFOX_PROFILE[name]=j81hfake.default
    declare -A FIREFOX_PROFILE

    function ff() {
      # Open Firefox with the specified profile
      local name="$*"

      if [[ ${FIREFOX_PROFILE[$name]+_} ]]
      then
        open -n -a "$FIREFOX_APP" --args -profile "$HOME/Library/Application Support/Firefox/Profiles/${FIREFOX_PROFILE[$name]}" -no-remote
      else
        printf 'Firefox profile "%s" not found' "$name" && return 1
      fi
    }
  fi
fi
