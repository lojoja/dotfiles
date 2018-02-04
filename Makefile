## TARGETS ##
install:	clean	install-bash	install-config	install-eslint	install-git
uninstall:	clean
clean: clean-bash	clean-config	clean-eslint	clean-git

# SCRIPT VARIABLES
HOME_PATH := /Users/$(shell whoami)
CONFIG_PATH := $(HOME_PATH)/.config
DOTFILE_PATH := $(HOME_PATH)/.dotfiles
BASH_CONF_PATH := $(DOTFILE_PATH)/bash
CONFIG_CONF_PATH := $(DOTFILE_PATH)/config
ESLINT_CONF_PATH := $(DOTFILE_PATH)/eslint
GIT_CONF_PATH := $(DOTFILE_PATH)/git

clean-bash:
	rm -f $(HOME_PATH)/.bash_profile

clean-config:
	rm -f $(CONFIG_PATH)/flake8
	rm -f $(CONFIG_PATH)/yamllint/config

clean-eslint:
	rm -f $(HOME_PATH)/.eslintrc
	rm -f $(HOME_PATH)/.eslintignore

clean-git:
	rm -f $(HOME_PATH)/.gitconfig
	rm -f $(HOME_PATH)/.gitignore

install-bash:
	ln -s $(BASH_CONF_PATH)/profile.sh $(HOME_PATH)/.bash_profile
	test -f $(BASH_CONF_PATH)/private.sh || cp $(BASH_CONF_PATH)/private.example.sh $(BASH_CONF_PATH)/private.sh
	test -f $(BASH_CONF_PATH)/local.sh || touch $(BASH_CONF_PATH)/local.sh
	test -f $(HOME_PATH)/.hushlogin || touch $(HOME_PATH)/.hushlogin

install-config:
	test -d $(CONFIG_PATH) || mkdir $(CONFIG_PATH)
	ln -s $(CONFIG_CONF_PATH)/flake8 $(CONFIG_PATH)/flake8
	test -d $(CONFIG_PATH)/yamllint || mkdir $(CONFIG_PATH)/yamllint
	ln -s $(CONFIG_CONF_PATH)/yamllint $(CONFIG_PATH)/yamllint/config

install-eslint:
	ln -s $(ESLINT_CONF_PATH)/eslintrc $(HOME_PATH)/.eslintrc
	ln -s $(ESLINT_CONF_PATH)/eslintignore $(HOME_PATH)/.eslintignore

install-git:
	ln -s $(GIT_CONF_PATH)/gitconfig $(HOME_PATH)/.gitconfig
	ln -s $(GIT_CONF_PATH)/gitignore $(HOME_PATH)/.gitignore
	test -f $(HOME_PATH)/.gitconfig-local || touch $(HOME_PATH)/.gitconfig-local
