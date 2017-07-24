# dotfiles/bash/program/ansible.sh

# Defaults
export ANSIBLE_REMOTE_TEMP='~/.ansible/tmp'
export ANSIBLE_LOCAL_TEMP='/tmp/ansible'
export ANSIBLE_VAULT_PASSWORD_FILE="$HOME/.ansible-vault"
export ANSIBLE_MANAGED=

# Connection
export ANSIBLE_USE_PERSISTENT_CONNECTIONS='True'
export ANSIBLE_SSH_ARGS='-C -o ControlMaster=auto -o ControlPersist=15m -o ForwardAgent=yes'
export ANSIBLE_SSH_CONTROL_PATH='%(directory)s/ssh-%%h-%%p-%%r'
export ANSIBLE_SSH_CONTROL_PATH_DIR="$ANSIBLE_LOCAL_TEMP"
#export ANSIBLE_SSH_PIPELINING='True'

# Display
export ANSIBLE_FORCE_COLOR='True'
export ANSIBLE_DISPLAY_SKIPPED_HOSTS='True'
export ANSIBLE_RETRY_FILES_ENABLED='False'

# Plugins
export ANSIBLE_SQUASH_ACTIONS=''
