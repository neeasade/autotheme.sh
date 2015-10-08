#!/bin/bash
# neeasade
# autotheme.sh
# goal: be made of less cancer

# relevant to this dir:

cd $( dirname $0 )

# Use urnn to get colors in xres format, translate to termite and create config.
./urnn/urnn.sh colors "$1" > colors.xresources

# pull the colors
# generate gtk from oomoox template
oomoxconf="./oomox/colors/auto.sh"
cp oomox_template $oomoxconf

# set the colors as variables:
eval $(cat colors.xresources | sed 's/*//' | sed 's/:/=/' | sed 's/ #//')

txtbg="$(./colort 1 "$background")"
sel="$(./colort 2 "$background")"
sed -i "s/bgreplace/${background}/g" $oomoxconf
sed -i "s/fgreplace/${foreground}/g" $oomoxconf
sed -i "s/txtreplace/${txtbg}/g" $oomoxconf
sed -i "s/selreplace/${sel}/g" $oomoxconf

# make the theme:
./oomox/change_color.sh auto

# Set the icon color:
~/.icons/acyl/scalable/scripts/icon.sh "#$foreground"

# Set gtk theme and icon theme in ~/.gtkrc-2.0, whilst keeping current settings:
# bash doesn't allow variables with a - in their names, so we are going to hack around that.
function addgtkval() {
	value="$(eval echo \$`echo $1 | sed 's/-/_/g'`)"
	echo "$1=\"$value\"" >> ~/.gtkrc-2.0
}

sed -i 's/-/_/g' ~/.gtkrc-2.0
. ~/.gtkrc-2.0 2>&1 > /dev/null
rm ~/.gtkrc-2.0

gtk_theme_name=oomox-auto
gtk_icon_theme_name=acyl

gtkvars="gtk-theme-name gtk-icon-theme-name gtk-font-name gtk-cursor-theme-name gtk-cursor-theme-size gtk-toolbar-style gtk-toolbar-icon-size gtk-button-images gtk-menu-images gtk-enable-event-sounds gtk-enable-input-feedback-sounds gtk-xft-antialias gtk-xft-hinting gtk-xft-hintstyle gtk-xft-rgba"

for i in $gtkvars; do
	addgtkval $i
done

./gtkrc-reload

xrdb merge ./colors.xresources
