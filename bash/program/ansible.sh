# dotfiles/bash/program/ansible.sh

# Defaults
ANSIBLE_REMOTE_TEMP='~/.ansible/tmp'
ANSIBLE_LOCAL_TEMP='/tmp/ansible'
ANSIBLE_VAULT_PASSWORD_FILE="$HOME/.ansible-vault"
ANSIBLE_MANAGED=

# Connection
ANSIBLE_USE_PERSISTENT_CONNECTIONS='True'
ANSIBLE_SSH_ARGS='-C -o ControlMaster=auto -o ControlPersist=15m -o ForwardAgent=yes'
ANSIBLE_SSH_CONTROL_PATH='%(directory)s/ssh-%%h-%%p-%%r'
ANSIBLE_SSH_CONTROL_PATH_DIR="$ANSIBLE_LOCAL_TEMP"
ANSIBLE_SSH_PIPELINING='True'

# Display
ANSIBLE_FORCE_COLOR='True'
ANSIBLE_DISPLAY_SKIPPED_HOSTS='True'
ANSIBLE_RETRY_FILES_ENABLED='False'

# Plugins
ANSIBLE_SQUASH_ACTIONS=''
