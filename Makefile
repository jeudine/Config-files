CONF		:= ~/.config
XMONAD_D	:= ~/.xmonad
XDM		:= /etc/X11/xdm
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
CARGO_UPDATE	:= ~/.cargo/bin/cargo-install-update
REDSHIFT	:= $(CONF)/redshift.conf
XDM_R		:= $(XDM)/Xresources
XDM_S		:= $(XDM)/Xsetup
CLANG_FORM	:= ~/.clang-format

VIM_PLUGINS	:= ~/.local/share/nvim/site/pack/plugins/start
LIGHTLINE	:= $(VIM_PLUGINS)/lightline
FUGITIVE	:= $(VIM_PLUGINS)/fugitive
ALE			:= $(VIM_PLUGINS)/ale
TOML		:= $(VIM_PLUGINS)/vim-toml

RM	:= rm -fr

TARGETS	= $(BASHRC) $(XMONAD) $(XSESSION) $(XMOBAR) $(NEOVIM) $(ROFI) $(GTK2) $(GTK3) $(ALACRITTY_C) $(REDSHIFT) $(CLANG_FORM)

NVIM_P	= $(LIGHTLINE) $(FUGITIVE) $(ALE) $(TOML)

DIR	= $(CONF) $(XMONAD_D)

ABSPATH	:= $(realpath .)

install:
	sudo apt install firmware-linux plymouth xorg xmonad xmobar network-manager feh arc-theme fonts-firacode xdm neovim rofi curl git network-manager redshift fonts-ipafont fonts-font-awesome asciidoctor ruby-asciidoctor-pdf ruby-pygments.rb brightnessctl glibc-doc
	make clean
	make $(TARGETS)
	make $(NVIM_P)
	make $(ALACRITTY)
	make $(CARGO_UPDATE)
	make install_xdm
	@echo "\033[01;32mWORK ENVIRONMENT SUCCESSFULLY INSTALLED!"

$(ALACRITTY): $(CARGO)
	sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
	~/.cargo/bin/cargo install alacritty

$(CARGO):
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

$(CARGO_UPDATE): $(CARGO)
	sudo apt install libssl-dev
	~/.cargo/bin/cargo install cargo-update bat exa

$(LIGHTLINE):
	git clone https://github.com/itchyny/lightline.vim $@

$(FUGITIVE):
	git clone https://tpope.io/vim/fugitive.git $@

$(ALE):
	git clone https://github.com/dense-analysis/ale.git $@

$(TOML):
	git clone https://github.com/cespare/vim-toml.git $@

clean:
	$(RM) $(TARGETS)

$(TARGETS): | $(DIR)
	FILE="$(shell echo $@ | rev | cut -d '/' -f 1 | rev)";\
	ln -sv $(ABSPATH)/$$FILE $@

$(DIR):
	mkdir -p $@

install_xdm:
	sudo $(RM) $(XDM_R) $(XDM_S)
	sudo ln -sv $(ABSPATH)/Xresources $(XDM_R)
	sudo ln -sv $(ABSPATH)/Xsetup $(XDM_S)

.PHONY: install clean install_xdm
