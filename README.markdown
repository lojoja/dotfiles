# dotfiles
lojoja's dotfiles


## Requirements
dotfiles requirements can be installed with [Homebrew](https://brew.sh).


### Shells
```
$ brew install bash
$ brew install zsh zsh-autosuggesstions zsh-completions
```

### Shell Configuration
```
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$ brew install pygments starship thefuck
```

### GNU tools
```
$ brew install coreutils findutils gnu-getopt gnu-sed gnu-tar gnu-time gnu-units gnu-which grep less
```

### Programs and Utilities
```
$ brew install ansible composer curl exiftool ffmpeg git git-gui gzip imagemagick jpeg less libyaml node rename ripgrep ruby shellcheck sqlite3 wget webp xz youtube-dl yt-dlp 
```

### Fonts
```
$ brew tap homebrew/cask-fonts
$ brew install --cask font-andale-mono font-dejavu font-fira-code-nerd-font font-fira-mono-for-powerline font-inconsolata font-sauce-code-pro-nerd-font font-source-code-pro
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
