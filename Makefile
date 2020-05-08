BASHRC	:= ~/.bashrc
XMONAD	:= ~/.xmonad/xmonad.hs
XMOBAR	:= ~/.xmonad/xmobar.hs
XSESSION:= ~/.xsession
KITTY	:= ~/.config/kitty/kitty.conf
NEOVIM	:= ~/.config/nvim
ROFI	:= ~/.config/rofi
GTK2	:= ~/.gtkrc-2.0
GTK3	:= ~/.config/gtk-3.0
RM	:= rm -fr

TARGETS	= $(BASHRC) $(XMONAD) $(XSESSION) $(KITTY) $(XMOBAR) $(NEOVIM) $(ROFI) $(GTK2) $(GTK3)

ABSPATH	:= $(realpath .)

install: $(TARGETS)

clean:
	$(RM) $(TARGETS)

$(TARGETS):
	FILE="$(shell echo $@ | rev | cut -d '/' -f 1 | rev)";\
	ln -sv $(ABSPATH)/$$FILE $@

.PHONY: install clean
