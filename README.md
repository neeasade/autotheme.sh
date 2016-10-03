## autotheme.sh

https://u.teknik.io/xFxa0g.webm

This repo is a mash up of the following projects/programs:

- [oomox](https://github.com/actionless/oomox)
- [ACYL Icons fork](https://github.com/neeasade/acyl)
- [URNN](https://github.com/nixers-projects/urnn)
- gtkrc-reload
- [colort](https://github.com/neeasade/colort)

### How do I use this?

Install the above listed programs (most available as AUR packages), and then:

```
./autotheme.sh "/path/to/image.file"
```

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
- arguments
- 'Manual' mode that takes in colors, no image needed.
- new webm
- update oomox content/format 
- package urnn, acyl in aur.

### misc
- The terminal in the webm is termite, which can autoreload it's settings.
- The panel in the webm is from my [dotfiles](https://github.com/neeasade/dotfiles)
- Thanks to Hexarei for playing guinea pig.
