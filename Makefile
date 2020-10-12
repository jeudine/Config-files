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
RM	:= rm -fr

TARGETS	= $(BASHRC) $(XMONAD) $(XSESSION) $(XMOBAR) $(NEOVIM) $(ROFI) $(GTK2) $(GTK3) $(ALACRITTY_C)

DIR	= $(CONF) $(XMONAD_D)

ABSPATH	:= $(realpath .)

install:
	sudo apt install xorg xmonad xmobar network-manager feh arc-theme fonts-firacode xdm neovim rofi curl git
	make $(TARGETS)
	make $(ALACRITTY)

$(ALACRITTY): $(CARGO)
	sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
	~/.cargo/bin/cargo install alacritty

$CARGO):
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

clean:
	$(RM) $(TARGETS)

$(TARGETS): | $(DIR)
	FILE="$(shell echo $@ | rev | cut -d '/' -f 1 | rev)";\
	ln -sv $(ABSPATH)/$$FILE $@

$(DIR):
	mkdir -p $@

.PHONY: install clean
