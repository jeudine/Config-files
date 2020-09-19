# Config-files
A backup of my different configuration files.

## Software

- [Bash](https://www.gnu.org/software/bash/)
- [Kitty](https://sw.kovidgoyal.net/kitty/)
- [Neovim](https://neovim.io/)
- [Rofi](https://github.com/davatorium/rofi)
- [Xdm](https://www.x.org/releases/X11R7.6/doc/man/man1/xdm.1.xhtml) (WIP)
- [Xmonad](https://xmonad.org/)
- [Xmobar](https://xmobar.org/)
- [Xsession](https://wiki.debian.org/Xsession)
- [GTK](https://www.gtk.org/)

## Installation

### Font
Install [FiraCode](https://github.com/tonsky/FiraCode).
```bash
sudo apt install fonts-firacode
```

### GTK Arc Theme
```bash
sudo apt install arc-theme
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
```bash
sudo apt install xmobar
```

### Xmonad
```bash
sudo apt install xmonad
```

### Xorg
```bash
sudo apt install xorg
```

### Network
Install Network manager and use `nmtui` or `nmcli`.
```bash
sudo apt install network-manager
```

### Configuration files
Use the following command to install the configuration files. Before, make sure you don't want to keep your current config files.
```bash
git clone git@github.com:Jeudine/Config-files.git
cd Config-files
make clean
make install
```
## License
Public domain.
