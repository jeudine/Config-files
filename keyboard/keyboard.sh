#!/bin/bash
KEYBOARD=crkbd
KEYMAP=julien
cd "$(dirname "$0")"
qmk setup -H ../qmk_firmware -y
cp -r $KEYMAP ../qmk_firmware/keyboards/$KEYBOARD/keymaps/
qmk compile -kb $KEYBOARD/rev1 -km $KEYMAP -e CONVERT_TO=promicro_rp2040
