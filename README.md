## autotheme.sh

https://u.teknik.io/xFxa0g.webm

This repo is a mash up of the following projects/programs:

- [oomox](https://github.com/actionless/oomox)
- [ACYL Icons](http://gnome-look.org/content/show.php/?content=102435)(Personal fork with an added script)
- [URNN](https://github.com/nixers-projects/urnn)
- gtkrc-reload
- [colort](https://gist.github.com/neeasade/a835a7946b3718e71f24)

### How do I use this?

First you will need to install [libfann](https://github.com/libfann/fann), for URNNs color generation.

After cloning:
```
./setup.sh
./autotheme.sh "/path/to/image.file"
```

`setup.sh` will compile the small gtkrc reload program and pull down the git submodules. It will also copy the acyl icons folder to `~/.icons/acyl`.

### autotheme.sh
This script will generate colors from an image using urnn, and then use those colors to make a gtk theme with oomox (named 'oomox-auto').

This script does the following:
- Generate colors from an image with urnn
- Make a gtk script from said colors with oomox(named 'oomox-auto')
- Call the acyl coloring bash script with the previously generated foreground color
- replace the gtk theme and icon theme values in your ~/.gtkrc-2.0 file
- Calls the gtkrc-reload program to live-reload your gtk programs
- Puts the generated colors in ./colors.xresources and calls `xrdb merge` on them for your terminal colorscheme

### misc
- The terminal in the webm is termite, which can autoreload it's settings.
- The panel in the webm is from my [dotfiles](github.com/neeasade/dotfiles)
