# dotfiles/bash/program/brave.sh

if [[ $DOTFILES_INIT_MAC -eq 1 ]]
then
  BRAVE_APP='/Applications/Brave Browser.app/Contents/MacOS/Brave Browser'
  BRAVE_ARGS='--enable-strict-mixed-content-checking'

  if [[ -r $BRAVE_APP ]]
  then
    # Array of profile names
    #
    # Profiles can be defined in dotfiles/bash/local.sh.
    # The profile name is the key and the profile number is the value, e.g.,:
    # BRAVE_PROFILE[name]=1
    declare -A BRAVE_PROFILE

    function bb() {
      # Open Brave Browser with $BRAVE_ARGS and the specified profile
      local name="$*"

      if [[ ${BRAVE_PROFILE[$name]+_} ]]
      then
        open -n -a "$BRAVE_APP" --args $BRAVE_ARGS --profile-directory="Profile ${BRAVE_PROFILE[$name]}"
      else
        printf 'Brave Browser profile "%s" not found' $name && return 1
      fi
    }
  fi
fi
