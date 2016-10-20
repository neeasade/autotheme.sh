#!/bin/sh
# neeasade
# autotheme.sh - generate xresources and gtk from a theme
# dependencies(available as AUR git packages): oomox colort urnn gtkrc-reload acyl
# goal: be made of less cancer

# if this script has 2+ arguments given, it will use an 'inverted' gtk style,
# with inverted active selection colors.

# make sure all the commands are available before running the script
programs="colort oomox-cli acyl-cli gtkrc-reload feh urnn"
for program in $programs; do
	if ! command -v "$program" 2> /dev/null; then
		echo "$program is not installed"
		echo "Get colort from https://github.com/neeasade/colort"
		echo "Get oomox-cli from https://github.com/actionless/oomox"
		echo "Get ACYL icons from https://github.com/neeasade/acyl"
		echo "Get urnn from https://github.com/nixers-projects/urnn"
		echo "Get gtkrc-reload and feh from your package manager"
		exit 1
	fi
done

# relevant to this dir:
cd "$(dirname "$0")" || {
	echo "Failed to change directory"
	exit 1
}

xres=$(mktemp)
echo "Dumping xresources to: $xres"

# Use urnn to get colors in xres format
urnn colors "$1" > "$xres"

# eval the colors as variables
eval "$(printf '%s' "$xres" | sed 's/*//;s/:/=/;s/ #//;s/ //g')"

# subtle or invert?
if [ "$#" -gt 1 ]; then
	sel_bg="$foreground"
	sel_fg="$background"
	icon_color=$(colort -c "$background" && colort 25 "$background" || colort -25 "$background")
else
	sel_bg=$(colort -c "$background" && colort 25 "$background" || colort -25 "$background")
	sel_fg="$foreground"
	icon_color="$(colort -c "$background" && colort -l 80 "$background" || colort -l -80 "$background")"
fi

oomoxconf="$(mktemp)"

# make the oomox template
cat << HEREDOC > $oomoxconf
NAME="{{THEME_NAME}}"
BG=$background
FG=$foreground
TXT_BG=\$BG
TXT_FG=\$FG
MENU_BG=\$BG
MENU_FG=\$FG
SEL_BG=$sel_bg
SEL_FG=$sel_fg
BTN_BG=\$BG
BTN_FG=\$FG
HEREDOC

# make the theme
oomox-cli $oomoxconf

# color icons
acyl-cli "$icon_color"

# get current gtk settings as vars (with - --> _)
sed -i 's/-/_/g' ~/.gtkrc-2.0
. ~/.gtkrc-2.0 2>&1
rm ~/.gtkrc-2.0

# set gtk and icon themes
gtk_theme_name="oomox-$(basename $oomoxconf)"
gtk_icon_theme_name=acyl
gtkvars="theme-name icon-theme-name font-name cursor-theme-name cursor-theme-size toolbar-style toolbar-icon-size button-images menu-images enable-event-sounds enable-input-feedback-sounds xft-antialias xft-hinting xft-hintstyle xft-rgba"

# write gtkrc
for i in $gtkvars; do
	value="$(eval echo \$`echo gtk-$i | sed 's/-/_/g'`)"
	echo "gtk-$i=\"$value\"" >> ~/.gtkrc-2.0
done

# reload gtk theme
gtkrc-reload

# load xresources
xrdb merge "$xres"

# silent failure if they don't have feh.
# todo: detect if image is small and tile if so
feh --bg-fill "$1" >/dev/null 2>&1
