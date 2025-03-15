CONF			:= ~/.config
BASHRC			:= ~/.bashrc
XSESSION		:= ~/.xsession
XINITRC			:= ~/.xinitrc
GITCONFIG		:= ~/.gitconfig
AVIM_POLISH:= $(CONF)/nvim/lua/polish.lua
AVIM_USER:= $(CONF)/nvim/lua/plugins/user.lua
ALACRITTY_C		:= $(CONF)/alacritty.toml
GTK2			:= ~/.gtkrc-2.0
GTK3			:= $(CONF)/gtk-3.0
ALACRITTY		:= ~/.cargo/bin/alacritty
CARGO			:= ~/.cargo/bin/cargo
CARGO_UPDATE	:= ~/.cargo/bin/cargo-install-update
REDSHIFT		:= $(CONF)/redshift.conf
CLANG_FMT		:= ~/.clang-format
AWESOME_DIR		:= $(CONF)/awesome
AWESOME			:= $(AWESOME_DIR)/rc.lua

RM	:= rm -fr

TARGETS	= $(BASHRC) $(XSESSION) $(XINITRC) $(GTK2) $(GTK3) $(ALACRITTY_C) $(REDSHIFT) $(CLANG_FMT) $(GITCONFIG) $(AWESOME) $(AVIM_USER) $(AVIM_POLISH)

DIR	= $(CONF) $(AWESOME_DIR)

ABSPATH	:= $(realpath .)

install:
	sudo apt install -y firmware-misc-nonfree xorg xcompmgr gcc network-manager feh git redshift glibc-doc exuberant-ctags clang-format curl awesome awesome-extra network-manager-gnome xfce4-power-manager pavucontrol libalsaplayer-dev libvulkan1 mesa-vulkan-drivers fonts-firacode
	make clean
	make $(TARGETS)
	make $(ALACRITTY)
	make $(CARGO_UPDATE)
	@echo "\033[01;32mWORK ENVIRONMENT SUCCESSFULLY INSTALLED!\033[00m"

$(ALACRITTY): $(CARGO)
	sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 -y
	~/.cargo/bin/cargo install alacritty

$(CARGO):
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

$(CARGO_UPDATE): $(CARGO)
	sudo apt install libssl-dev -y
	~/.cargo/bin/cargo install cargo-update bat exa

clean:
	$(RM) $(TARGETS)

$(TARGETS): | $(DIR)
	FILE="$(shell echo $@ | rev | cut -d '/' -f 1 | rev)";\
		 ln -sv $(ABSPATH)/$$FILE $@

$(DIR):
	mkdir -p $@


.PHONY: install clean
