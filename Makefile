## TARGETS ##
install:	clean	install-bash	install-config	install-zsh
uninstall:	clean
clean: clean-bash	clean-config	clean-zsh

# SCRIPT VARIABLES
HOME_PATH := /Users/$(shell whoami)
CONFIG_PATH := $(HOME_PATH)/.config
DOTFILE_PATH := $(HOME_PATH)/.dotfiles
BASH_CONF_PATH := $(DOTFILE_PATH)/bash
CONFIG_CONF_PATH := $(DOTFILE_PATH)/config
ZSH_CONF_PATH := $(DOTFILE_PATH)/zsh

clean-bash:
	rm -f $(HOME_PATH)/.bash_profile
	rm -f $(HOME_PATH)/.bashrc

clean-config:
	rm -f $(HOME_PATH)/.eslintrc
	rm -f $(HOME_PATH)/.eslintignore
	rm -f $(HOME_PATH)/.gitconfig
	rm -f $(HOME_PATH)/.gitconfig-local
	rm -f $(HOME_PATH)/.gitignore
	rm -f $(CONFIG_PATH)/.ExifTool_config
	rm -f $(CONFIG_PATH)/flake8
	rm -f $(CONFIG_PATH)/pip.conf
	rm -rf $(CONFIG_PATH)/poetry
	rm -f $(CONFIG_PATH)/starship.toml
	rm -rf $(CONFIG_PATH)/yamllint

clean-zsh:
	rm -f $(HOME_PATH)/.zshrc

install-bash:
	ln -s $(BASH_CONF_PATH)/profile.sh $(HOME_PATH)/.bash_profile
	ln -s $(BASH_CONF_PATH)/rc.sh $(HOME_PATH)/.bashrc
	test -f $(BASH_CONF_PATH)/private.sh || cp $(BASH_CONF_PATH)/private.example.sh $(BASH_CONF_PATH)/private.sh
	test -f $(BASH_CONF_PATH)/local.sh || touch $(BASH_CONF_PATH)/local.sh
	test -f $(HOME_PATH)/.hushlogin || touch $(HOME_PATH)/.hushlogin

install-config:
	ln -s $(CONFIG_CONF_PATH)/eslint/eslintrc $(HOME_PATH)/.eslintrc
	ln -s $(CONFIG_CONF_PATH)/eslint/eslintignore $(HOME_PATH)/.eslintignore
	ln -s $(CONFIG_CONF_PATH)/git/gitconfig $(HOME_PATH)/.gitconfig
	test -f $(CONFIG_CONF_PATH)/git/gitconfig-local || cp $(CONFIG_CONF_PATH)/git/gitconfig-local.example $(CONFIG_CONF_PATH)/git/gitconfig-local
	ln -s $(CONFIG_CONF_PATH)/git/gitconfig-local $(HOME_PATH)/.gitconfig-local
	ln -s $(CONFIG_CONF_PATH)/git/gitignore $(HOME_PATH)/.gitignore
	test -d $(CONFIG_PATH) || mkdir $(CONFIG_PATH)
	ln -s $(CONFIG_CONF_PATH)/ExifTool_config $(CONFIG_PATH)/.ExifTool_config
	ln -s $(CONFIG_CONF_PATH)/flake8 $(CONFIG_PATH)/flake8
	ln -s $(CONFIG_CONF_PATH)/pip.conf $(CONFIG_PATH)/pip.conf
	ln -s $(CONFIG_CONF_PATH)/poetry $(CONFIG_PATH)/poetry
	ln -s $(CONFIG_CONF_PATH)/starship.toml $(CONFIG_PATH)/starship.toml
	ln -s $(CONFIG_CONF_PATH)/yamllint $(CONFIG_PATH)/yamllint

install-zsh:
	ln -s $(ZSH_CONF_PATH)/rc.zsh $(HOME_PATH)/.zshrc
	test -f $(ZSH_CONF_PATH)/private.zsh || cp $(ZSH_CONF_PATH)/private.example.zsh $(ZSH_CONF_PATH)/private.zsh
	test -f $(ZSH_CONF_PATH)/local.zsh || touch $(ZSH_CONF_PATH)/local.zsh
