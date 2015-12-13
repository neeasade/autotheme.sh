#!/bin/bash
# neeasade
# autotheme.sh
# goal: be made of less cancer

# if this script has 2+ arguments given, it will use an 'inverted' gtk style,
# with inverted active selection colors.

# relevant to this dir:
cd $( dirname $0 )/auto

# Use urnn to get colors in xres format
./urnn/urnn.sh colors "$1" > colors.xresources

# pull the colors
# generate gtk from oomoox template
oomoxconf="./oomox/colors/auto.sh"

if [ -z "$2" ]; then
	cp oomox_template_subtle $oomoxconf
else
	cp oomox_template_invert $oomoxconf
fi

# set the colors as variables, and evaluate them.
eval $(cat colors.xresources | sed 's/*//' | sed 's/:/=/' | sed 's/ #//')

sed -i "s/bgreplace/${background}/g;s/fgreplace/${foreground}/g" $oomoxconf

if [ -z "$2" ]; then
	sel="$(./colort 1 "$background")"
	sed -i "s/selreplace/${sel}/g" $oomoxconf
fi

# make the theme:
./oomox/change_color.sh auto

# Set the icon color:
if [ -z "$2" ]; then
	~/.icons/acyl/scalable/scripts/icon.sh "#$foreground"
else
	# lower the icon color from the foreground so that you can see icons on selected items.
	~/.icons/acyl/scalable/scripts/icon.sh "#$(./colort -3 $foreground)"
fi

# Set gtk theme and icon theme in ~/.gtkrc-2.0, whilst keeping current settings:
# bash doesn't allow variables with a - in their names, so we are going to hack around that.
function addgtkval() {
	value="$(eval echo \$`echo $1 | sed 's/-/_/g'`)"
	echo "$1=\"$value\"" >> ~/.gtkrc-2.0
}

sed -i 's/-/_/g' ~/.gtkrc-2.0

. ~/.gtkrc-2.0 2>&1
rm ~/.gtkrc-2.0

gtk_theme_name=oomox-auto
gtk_icon_theme_name=acyl

gtkvars="gtk-theme-name gtk-icon-theme-name gtk-font-name gtk-cursor-theme-name gtk-cursor-theme-size gtk-toolbar-style gtk-toolbar-icon-size gtk-button-images gtk-menu-images gtk-enable-event-sounds gtk-enable-input-feedback-sounds gtk-xft-antialias gtk-xft-hinting gtk-xft-hintstyle gtk-xft-rgba"

for i in $gtkvars; do
	addgtkval $i
done

# reload gtk theme
./gtkrc-reload

# load xresources
xrdb merge ./colors.xresources

# silent failure if they don't have feh.
feh --bg-fill "$1" 2>&1 > /dev/null
