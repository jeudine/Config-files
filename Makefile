BASHRC		:= ~/.bashrc
XMONAD		:= ~/.xmonad/xmonad.hs
XMOBAR		:= ~/.xmonad/xmobar.hs
XSESSION	:= ~/.xsession
NEOVIM		:= ~/.config/nvim
ROFI		:= ~/.config/rofi
GTK2		:= ~/.gtkrc-2.0
GTK3		:= ~/.config/gtk-3.0
ALACRITTY	:= ~/.cargo/bin/alacritty
CARGO		:= ~/.cargo/bin/cargo
RM	:= rm -fr

TARGETS	= $(BASHRC) $(XMONAD) $(XSESSION) $(XMOBAR) $(NEOVIM) $(ROFI) $(GTK2) $(GTK3)

ABSPATH	:= $(realpath .)

install: $(TARGETS) $(ALACRITTY)
	sudo apt install xorg xmonad xmobar network-manager feh arc-theme fonts-firacode xdm neovim rofi curl git

$(ALACRITTY): $(CARGO)
	sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
	~/.cargo/bin/cargo install alacritty

$CARGO):
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

clean:
	$(RM) $(TARGETS)

$(TARGETS):
	FILE="$(shell echo $@ | rev | cut -d '/' -f 1 | rev)";\
	ln -sv $(ABSPATH)/$$FILE $@


.PHONY: install clean
