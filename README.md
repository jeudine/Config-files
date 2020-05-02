# Config-files
A backup of my different configuration files.

## Software

- [Bash](https://www.gnu.org/software/bash/)
- [Kitty](https://sw.kovidgoyal.net/kitty/)
- [Neovim](https://neovim.io/)
- [Rofi](https://github.com/davatorium/rofi) (WIP)
- [Xdm](https://www.x.org/releases/X11R7.6/doc/man/man1/xdm.1.xhtml) (WIP)
- [Xmonad](https://xmonad.org/)
- [Xmobar](https://xmobar.org/)
- [Xsession](https://wiki.debian.org/Xsession)

## Installation

### Font
Install [FiraCode](https://github.com/tonsky/FiraCode).
```bash
sudo apt install fonts-firacode
```

### Neovim plugins
Install the plugins [Lightline](https://github.com/itchyny/lightline.vim) and [Fugitive](https://github.com/tpope/vim-fugitive).
```bash
git clone https://github.com/itchyny/lightline.vim ~/.local/share/nvim/site/pack/lightline/start/lightline
git clone https://tpope.io/vim/fugitive.git ~/.local/share/nvim/site/pack/tpope/start/fugitive/
```

### Wallpaper
Install [Feh](https://feh.finalrewind.org/).
```bash
sudo apt install feh
```
Modify `.xsession` to indicate the path of your wallpaper.

### Xmobar
Use [Cabal](https://www.haskell.org/cabal/) with the right flag.
```bash
cabal install xmobar --flags="with_xft"
```

### Configuration files
Use the following command to install the configuration files. Before, make sure you don't want to keep your current config files.
```bash
git clone git@github.com:Jeudine/Config-files.git
cd Config-files
make clean
make install
```
