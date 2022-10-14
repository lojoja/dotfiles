# dotfiles/zsh/custom/ansible.zsh
# shellcheck shell=zsh

# Defaults
# shellcheck disable=2016
export ANSIBLE_REMOTE_TEMP='$HOME/.ansible/tmp'
export ANSIBLE_LOCAL_TEMP='/tmp/ansible'
export ANSIBLE_VAULT_PASSWORD_FILE="$HOME/.ansible-vault"

# Connection
export ANSIBLE_SSH_CONTROL_PATH='%(directory)s/ssh-%%h-%%p-%%r'
export ANSIBLE_SSH_CONTROL_PATH_DIR="$ANSIBLE_LOCAL_TEMP"
export ANSIBLE_SSH_PIPELINING=1

# Display
export ANSIBLE_FORCE_COLOR=1
export ANSIBLE_DISPLAY_SKIPPED_HOSTS=1
export ANSIBLE_RETRY_FILES_ENABLED=0

# Plugins
export ANSIBLE_SQUASH_ACTIONS=''
