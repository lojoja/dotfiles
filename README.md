# dotfiles

lojoja's dotfiles

## Requirements

- macOS
- [Homebrew](https://brew.sh)
- [MacPorts](https://macports.org)
- git
- zsh

## Install

The [dotfiles-install](https://github.com/lojoja/dotfiles-install) repository contains the standalone installation script. This script installs all additional requirements and dependencies from MacPorts and Homebrew. Install dotfiles by running the following command:

```
$ /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/lojoja/dotfiles-install/main/install.zsh)"
```

## Uninstall

The [dotfiles-install](https://github.com/lojoja/dotfiles-install) repository contains the standalone uninstall script. Uninstall dotfiles by running the following command:

```
$ /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/lojoja/dotfiles-install/main/uninstall.zsh)"
```

**Note:** The uninstall script removes dotfiles settings and files, but does not remove MacPorts or Homebrew packages installed by the installation script as doing so may fail due to, or break, other package dependencies.

## Usage

The `dotfiles` command can be used to update packages, settings, view encrypted secrets, and set the password for encrypted files. All commands except `password` accept a `-t/--test` option to check what changes would be made without altering the system.

```
Usage: dotfiles [OPTIONS] COMMAND [ARGS...]

  Manage dotfiles on this system

Options:
  -h, --help  Show this message and exit

Commands:
  install    Install dotfiles
  packages   Manage dotfiles packages on this system
  password   Set/validate the dotfiles vault password
  secrets    Show dotfiles secrets
  uninstall  Uninstall dotfiles
  update     Update dotfiles
```

**Note:** The `install` command should not be used for an initial installation. The `uninstall` command can be used to remove active settings and files, but a full uninstall requires the [dotfiles-install uninstall script](#Uninstall)

### Shell environment variables

Environment variables managed by dotfiles are set in `$HOME/.env`. Local overrides and additional environment variables can be placed in the `$HOME/.env.local` file. Values in this file will not be changed when dotfiles is updated, however this file will be removed if dotfiles is uninstalled.

## License

dotfiles is released under the [MIT License](./LICENSE)
