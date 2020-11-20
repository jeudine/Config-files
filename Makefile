CONF		:= ~/.config
XMONAD_D	:= ~/.xmonad
BASHRC		:= ~/.bashrc
XMONAD		:= $(XMONAD_D)/xmonad.hs
XMOBAR		:= $(XMONAD_D)/xmobar.hs
XSESSION	:= ~/.xsession
NEOVIM		:= $(CONF)/nvim
ALACRITTY_C	:= $(CONF)/alacritty.yml
ROFI		:= $(CONF)/rofi
GTK2		:= ~/.gtkrc-2.0
GTK3		:= $(CONF)/gtk-3.0
ALACRITTY	:= ~/.cargo/bin/alacritty
CARGO		:= ~/.cargo/bin/cargo
REDSHIFT	:= $(CONF)/redshift.conf

LIGHTLINE	:= ~/.local/share/nvim/site/pack/lightline/start/lightline/
FUGITIVE	:= ~/.local/share/nvim/site/pack/tpope/start/fugitive/

RM	:= rm -fr

TARGETS	= $(BASHRC) $(XMONAD) $(XSESSION) $(XMOBAR) $(NEOVIM) $(ROFI) $(GTK2) $(GTK3) $(ALACRITTY_C) $(REDSHIFT)

NVIM_P	= $(LIGHTLINE) $(FUGITIVE)

DIR	= $(CONF) $(XMONAD_D)

ABSPATH	:= $(realpath .)

install:
	sudo apt install xorg xmonad xmobar network-manager feh arc-theme fonts-firacode xdm neovim rofi curl git network-manager redshift
	make clean
	make $(TARGETS)
	make $(NVIM_P)
	make $(ALACRITTY)
	@echo "\033[01;32mWORK ENVIRONMENT SUCCESSFULLY INSTALLED!"

$(ALACRITTY): $(CARGO)
	sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
	~/.cargo/bin/cargo install alacritty

$(CARGO):
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

$(LIGHTLINE):
	git clone https://github.com/itchyny/lightline.vim $@

$(FUGITIVE):
	git clone https://tpope.io/vim/fugitive.git $@

clean:
	$(RM) $(TARGETS)

$(TARGETS): | $(DIR)
	FILE="$(shell echo $@ | rev | cut -d '/' -f 1 | rev)";\
	ln -sv $(ABSPATH)/$$FILE $@

$(DIR):
	mkdir -p $@

.PHONY: install clean
