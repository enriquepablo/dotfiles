#!/bin/bash
 
# Load resources
 
# xrdb -merge .Xresources
xsetroot -cursor_name left_ptr &
xsetroot -solid midnightblue &
xrdb -merge  ~/.Xdefaults &
 
#stalonetray &
 
# Set the background color<
 
#xsetroot -solid midnightblue
# xpmroot ~/background.png &
 
# Fire up apps
 
# pidgin &

xloadimage -onroot -fullscreen /home/eperez/Firefox_wallpaper.png

xscreensaver -no-splash &
 
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session  /home/eperez/.cabal/bin/xmonad
