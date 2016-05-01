## autotheme.sh

https://u.teknik.io/xFxa0g.webm

This repo is a mash up of the following projects/programs:

- [oomox](https://github.com/actionless/oomox)
- [ACYL Icons](http://gnome-look.org/content/show.php/?content=102435)(Personal fork with an added script)
- [URNN](https://github.com/nixers-projects/urnn)
- gtkrc-reload
- [colort](https://github.com/26c8/colort)

### How do I use this?

You will need the following dependencies: libpng, gtk2, [libfann](https://github.com/libfann/fann), and optionally, feh.

This has been primarily used on Arch and there have been issues with other distros due to older libpng versions.

After cloning:
```
./setup.sh
./autotheme.sh "/path/to/image.file"
```

`setup.sh` will compile the small gtkrc reload program and pull down the git submodules. It will also copy the acyl icons folder to `~/.icons/acyl`.

### autotheme.sh
This script does the following:
- Generate colors from an image with urnn
- Make a gtk script from said colors with oomox(named 'oomox-auto')
- Call the acyl coloring bash script with the previously generated foreground color
- replace the gtk theme and icon theme values in your ~/.gtkrc-2.0 file
- Calls the gtkrc-reload program to live-reload your gtk programs
- Puts the generated colors in ./colors.xresources and calls `xrdb merge` on them for your terminal colorscheme
- If you have feh, the image will be set as your background.

### subtle vs invert gtk styles.

By default this script will use a 'subtle' gtk style, but if you include any argument after your image file, an inverted gtk style will be produced. to make it clear what I mean by that:

subtle | invert
-------|--------
![subtle](https://u.teknik.io/3dclwG.png) | ![invert](https://u.teknik.io/bYAvQA.png)

### todo
- Make this less ghetto /arguments
- 'Manual' mode that takes in colors and spits out simple gtk, either inverted or subtle

### misc
- The terminal in the webm is termite, which can autoreload it's settings.
- The panel in the webm is from my [dotfiles](github.com/neeasade/dotfiles)
- Thanks to Hexarei for playing guinea pig.
