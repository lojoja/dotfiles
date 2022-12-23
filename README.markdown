# dotfiles

lojoja's dotfiles


## Dependencies and Requirements
dotfiles requirements can be installed with [MacPorts](https://macports.org) and [Homebrew](https://brew.sh).


### Bootstrap system
```
$ sudo ./bootstrap/mpbootstrap.zsh
$ ./bootstrap/hbbootstrap.zsh
```

### Configure system

Edit `/etc/paths` inserting `/opt/local/bin` and `/usr/local/bin`.

Edit `/etc/shells` inserting `/opt/local/bin/bash` and `/opt/local/bin/zsh`.

Change shell with `chsh -s /opt/local/bin/bash` or `chsh -s /opt/local/bin/zsh`.


### OhMyZsh Shell Configuration
```
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```


## Installation
```
$ cd ~
$ git clone https://github.com/lojoja/dotfiles.git .dotfiles
$ cd .dotfiles
$ make install
```


License
-------
dotfiles is released under the [MIT License](./LICENSE)
