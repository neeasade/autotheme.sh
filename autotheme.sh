#!/bin/bash
# neeasade
# autotheme.sh
# goal: be made of less cancer

# relevant to this dir:

cd $( dirname $0 )

# Use urnn to get colors in xres format, translate to termite and create config.
./urnn.sh colors "$1" > colors.xresources

# pull the colors

# asdfasdf review from here down

termiteconf="$HOME/.config/termite/themes/temptheme.config"
cat ~/bin/autotheme/termitestart > $termiteconf
$urnn colors `pwd`/$1 | sed 's/*//' | sed 's/:/=/' >> $termiteconf

themeconf="$HOME/.config/bspwm/themes/temptheme.bspwm_theme"
cat ~/bin/autotheme/template > $themeconf
imagepath="`pwd`/$1"
fehpath="$(echo $imagepath | sed 's/\//\\\//g')"
sed -i "s/fehreplace/$fehpath/g" $themeconf

# oomox
oomoxconf=$HOME/git/oomox/colors/temptheme.sh
cat ~/bin/autotheme/oomox > $oomoxconf
# literally cancer:
eval $($urnn colors $(pwd)/$1 | sed 's/*//' | sed 's/:/=/' | sed 's/ #//')
txtbg="$(colort 1 "$background")"
sel="$(colort 2 "$background")"
sed -i "s/bgreplace/${background}/g" $oomoxconf
sed -i "s/fgreplace/${foreground}/g" $oomoxconf
sed -i "s/txtreplace/${txtbg}/g" $oomoxconf
sed -i "s/selreplace/${sel}/g" $oomoxconf

# call oomox
~/git/oomox/change_color.sh temptheme

# call ACYL
cd ~/.icons/ACYL/scalable/scripts
./icon.sh "#$foreground"

# load the thing.
ltheme temptheme

