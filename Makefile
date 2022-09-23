## TARGETS ##
install:	clean	install-bash	install-config	install-eslint	install-exiftool	install-git
uninstall:	clean
clean: clean-bash	clean-config	clean-eslint	clean-exiftool	clean-git

# SCRIPT VARIABLES
HOME_PATH := /Users/$(shell whoami)
CONFIG_PATH := $(HOME_PATH)/.config
DOTFILE_PATH := $(HOME_PATH)/.dotfiles
BASH_CONF_PATH := $(DOTFILE_PATH)/bash
CONFIG_CONF_PATH := $(DOTFILE_PATH)/config
ESLINT_CONF_PATH := $(DOTFILE_PATH)/eslint
EXIF_CONF_PATH := $(DOTFILE_PATH)/exiftool
GIT_CONF_PATH := $(DOTFILE_PATH)/git

clean-bash:
	rm -f $(HOME_PATH)/.bash_profile
	rm -f $(HOME_PATH)/.bashrc

clean-config:
	rm -f $(CONFIG_PATH)/flake8
	rm -f $(CONFIG_PATH)/poetry/config.toml
	rm -f $(CONFIG_PATH)/yamllint/config

clean-eslint:
	rm -f $(HOME_PATH)/.eslintrc
	rm -f $(HOME_PATH)/.eslintignore

clean-exiftool:
	rm -f $(HOME_PATH)/.ExifTool_config

clean-git:
	rm -f $(HOME_PATH)/.gitconfig
	rm -f $(HOME_PATH)/.gitconfig-local
	rm -f $(HOME_PATH)/.gitignore

install-bash:
	ln -s $(BASH_CONF_PATH)/profile.sh $(HOME_PATH)/.bash_profile
	ln -s $(BASH_CONF_PATH)/rc.sh $(HOME_PATH)/.bashrc
	test -f $(BASH_CONF_PATH)/private.sh || cp $(BASH_CONF_PATH)/private.example.sh $(BASH_CONF_PATH)/private.sh
	test -f $(BASH_CONF_PATH)/local.sh || touch $(BASH_CONF_PATH)/local.sh
	test -f $(HOME_PATH)/.hushlogin || touch $(HOME_PATH)/.hushlogin

install-config:
	test -d $(CONFIG_PATH) || mkdir $(CONFIG_PATH)
	ln -s $(CONFIG_CONF_PATH)/flake8 $(CONFIG_PATH)/flake8
	test -d $(CONFIG_PATH)/poetry || mkdir $(CONFIG_PATH)/poetry
	ln -s $(CONFIG_CONF_PATH)/poetry.toml $(CONFIG_PATH)/poetry/config.toml
	test -d $(CONFIG_PATH)/yamllint || mkdir $(CONFIG_PATH)/yamllint
	ln -s $(CONFIG_CONF_PATH)/yamllint $(CONFIG_PATH)/yamllint/config

install-eslint:
	ln -s $(ESLINT_CONF_PATH)/eslintrc $(HOME_PATH)/.eslintrc
	ln -s $(ESLINT_CONF_PATH)/eslintignore $(HOME_PATH)/.eslintignore

install-exiftool:
	ln -s $(EXIF_CONF_PATH)/ExifTool_config $(HOME_PATH)/.ExifTool_config

install-git:
	ln -s $(GIT_CONF_PATH)/gitconfig $(HOME_PATH)/.gitconfig
	test -f $(GIT_CONF_PATH)/gitconfig-local || cp $(GIT_CONF_PATH)/gitconfig-local.example $(GIT_CONF_PATH)/gitconfig-local
	ln -s $(GIT_CONF_PATH)/gitconfig-local $(HOME_PATH)/.gitconfig-local
	ln -s $(GIT_CONF_PATH)/gitignore $(HOME_PATH)/.gitignore
