CONF			:= ~/.config
BASHRC			:= ~/.bashrc
XSESSION		:= ~/.xsession
XINITRC			:= ~/.xinitrc
GITCONFIG		:= ~/.gitconfig
NEOVIM			:= $(CONF)/nvim
ALACRITTY_C		:= $(CONF)/alacritty.toml
GTK2			:= ~/.gtkrc-2.0
GTK3			:= $(CONF)/gtk-3.0
ALACRITTY		:= ~/.cargo/bin/alacritty
CARGO			:= ~/.cargo/bin/cargo
CARGO_UPDATE	:= ~/.cargo/bin/cargo-install-update
REDSHIFT		:= $(CONF)/redshift.conf
CLANG_FMT		:= ~/.clang-format
RUST_FMT_DIR	:= $(CONF)/rustfmt
RUST_FMT		:= $(RUST_FMT_DIR)/rustfmt.toml
AWESOME_DIR		:= $(CONF)/awesome
AWESOME			:= $(AWESOME_DIR)/rc.lua

VIM_PLUGINS	:= ~/.local/share/nvim/site/pack/plugins/start
LIGHTLINE	:= $(VIM_PLUGINS)/lightline
FUGITIVE	:= $(VIM_PLUGINS)/fugitive
ALE			:= $(VIM_PLUGINS)/ale
TOML		:= $(VIM_PLUGINS)/vim-toml
RUST_VIM	:= $(VIM_PLUGINS)/rust.vim

RM	:= rm -fr

TARGETS	= $(BASHRC) $(XSESSION) $(XINITRC) $(NEOVIM) $(GTK2) $(GTK3) $(ALACRITTY_C) $(REDSHIFT) $(CLANG_FMT) $(RUST_FMT) $(GITCONFIG) $(AWESOME)

NVIM_P	= $(LIGHTLINE) $(FUGITIVE) $(ALE) $(TOML) $(RUST_VIM)

DIR	= $(CONF) $(RUST_FMT_DIR) $(AWESOME_DIR)

ABSPATH	:= $(realpath .)

install:
	sudo apt install -y firmware-misc-nonfree xorg xcompmgr gcc network-manager feh neovim git redshift fonts-firacode fonts-font-awesome glibc-doc exuberant-ctags clang-format curl awesome awesome-extra network-manager-gnome xfce4-power-manager pavucontrol libalsaplayer-dev libvulkan1 mesa-vulkan-drivers
	make clean
	make $(TARGETS)
	make $(NVIM_P)
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

$(LIGHTLINE):
	git clone https://github.com/itchyny/lightline.vim $@

$(FUGITIVE):
	git clone https://tpope.io/vim/fugitive.git $@

$(ALE):
	git clone https://github.com/dense-analysis/ale.git $@

$(TOML):
	git clone https://github.com/cespare/vim-toml.git $@

$(RUST_VIM):
	git clone https://github.com/rust-lang/rust.vim.git $@

clean:
	$(RM) $(TARGETS)

$(TARGETS): | $(DIR)
	FILE="$(shell echo $@ | rev | cut -d '/' -f 1 | rev)";\
		 ln -sv $(ABSPATH)/$$FILE $@

$(DIR):
	mkdir -p $@


.PHONY: install clean
