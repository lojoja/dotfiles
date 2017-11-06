## TARGETS ##
install:	clean-bash	clean-git	install-bash	install-git
uninstall:	clean-bash	clean-git

# SCRIPT VARIABLES
HOME_PATH := /Users/$(shell whoami)
DOTFILE_PATH := $(HOME_PATH)/.dotfiles
BASH_CONF_PATH := $(DOTFILE_PATH)/bash
GIT_CONF_PATH := $(DOTFILE_PATH)/git

clean-bash:
	rm -f $(HOME_PATH)/.bash_profile

clean-git:
	rm -f $(HOME_PATH)/.gitconfig
	rm -f $(HOME_PATH)/.gitignore

install-bash:
	ln -s $(BASH_CONF_PATH)/profile.sh $(HOME_PATH)/.bash_profile
	test -f $(BASH_CONF_PATH)/private.sh || cp $(BASH_CONF_PATH)/private.example.sh $(BASH_CONF_PATH)/private.sh
	test -f $(BASH_CONF_PATH)/local.sh || touch $(BASH_CONF_PATH)/local.sh
	test -f $(HOME_PATH)/.hushlogin || touch $(HOME_PATH)/.hushlogin

install-git:
	ln -s $(GIT_CONF_PATH)/gitconfig $(HOME_PATH)/.gitconfig
	ln -s $(GIT_CONF_PATH)/gitignore $(HOME_PATH)/.gitignore
	test -f $(HOME_PATH)/.gitconfig-local || touch $(HOME_PATH)/.gitconfig-local
