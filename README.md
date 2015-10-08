## autotheme.sh

https://u.teknik.io/xFxa0g.webm

This repo is a mash up of the following projects:

- [oomox](https://github.com/actionless/oomox)
- [ACYL Icons](http://gnome-look.org/content/show.php/?content=102435)(Personal fork with an added script)
- [URNN](https://github.com/nixers-projects/urnn)
- gtkrc-reload

### How do I use this?

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
- Replace your ~/.gtkrk-2.0 file (with oomox gtk, acyl icons, monospace font)(backs up existing gtkrc-2.0 > ~/.gtkrc-2.0.backup)
- Calls the gtkrc-reload program to live-reload your gtk programs
- Puts the generates colors in ./pulled.colors and calls `xrdb merge` on them for your terminal

### misc
- The terminal in the webm is termite, which can autoreload it's settings.
