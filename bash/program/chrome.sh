# dotfiles/bash/program/chrome.sh

if [[ $DOTFILES_INIT_MAC -eq 1 ]]
then
  CHROME_APP='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
  CHROME_ARGS='--enable-strict-mixed-content-checking'

  # Array of profile names
  #
  # Profiles can be defined in dotfiles/bash/local.sh.
  # The profile name is the key and the profile number is the value, e.g.,:
  # CHROME_PROFILE[name]=1
  declare -A CHROME_PROFILE

  function gc() {
    # Open Google Chrome with $CHROME_ARGS and the specified profile
    local name="$*"

    if [[ ${CHROME_PROFILE[$name]+_} ]]
    then
      open -n -a "$CHROME_APP" --args $CHROME_ARGS --profile-directory="Profile ${CHROME_PROFILE[$name]}"
    else
      printf 'Google Chrome profile "%s" not found' $name && return 1
    fi
  }
fi
