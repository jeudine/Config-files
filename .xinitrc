xcompmgr -c -l0 -t0 -r0 -o.00 &
blueman-applet &
nm-applet &
xfce4-power-manager --deamon &
xrandr --output HDMI-1 --auto --same-as eDP-1
dbus-update-activation-environment DISPLAY XAUTHORITY
awesome
