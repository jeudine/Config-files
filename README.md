# Config-files

A backup of my different configuration files.

## Installation

To install my configuration files run the following command in the root folder of the repository. The existing ones will be overwritten.


```shell
make install
```

## Update

To update all the installed packages, you can run the following command.

```shell
update
```

## Misc.

* To add a usb group in Debian run  the `usb_group_debian.sh` script as the superuser.
* To change the keyboard layout run `sudo dpkg-reconfigure keyboard-configuration` (`Generic 105-key PC`, `English (US) - English (intl., with AltGr dead keys)`, `The default for the keyboard layout`, `Right Alt (AltGr)`).
* Mirror eDP-1 on HDMI-1 `xrandr --output HDMI-1 --auto --same-as eDP-1`
* Extend eDP-1 to HDMI-1 (on the right) `xrandr --output HDMI-1 --auto --right-of eDP-1`
* To allow Network Manager to work with every interface, set `managed` to true in `/etc/NetworkManager/NetworkManager.conf`
* Check if network interface defined in /etc/network/interfaces

## License

Public domain.

