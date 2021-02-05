<p align="center"><a name="top" href="#penguin-my-personal-dotfiles"><img height="60%" width="100%" src="https://github.com/miikanissi/dotfiles/blob/master/.config/gallery/dotfiles.png?raw=true" alt="Dotfiles Header"></a></p>

##
## :penguin: My Personal Dotfiles!

<a href="https://miikanissi.com"><img src="https://github.com/miikanissi/dotfiles/blob/master/.config/gallery/arch_desktop.png?raw=true" alt="desktop-thumbnail" align="right" width="400px"></a>

This is my personal configuration for a custom "Desktop Environment" and other useful programs. To see a list of all my programs check [program_list_arch.csv](https://github.com/miikanissi/dotfiles/master/arch/program_list_arch.csv).

Here are the details of my setup:
- **Distro** 	     : [Arch](https://www.archlinux.org/) :computer: Currently using Arch, previously Fedora & Ubuntu
- **WM**     	     : [BSPWM](https://github.com/baskerville/bspwm) :tv: Manual tiling window manager
- **DM**	     : [LightDM](https://github.com/canonical/lightdm)
- **Shell**	     : [GNU Bash](https://www.gnu.org/software/bash/) :shell: Who needs more than bash
- **Terminal**	     : [URxvt](https://wiki.archlinux.org/index.php/Rxvt-unicode) :art: Hopscotch colors
- **Panel**	     : [Polybar](https://github.com/polybar/polybar) :black_square_button: Easy to add custom modules
- **Compositor**     : [Picom](https://wiki.archlinux.org/index.php/Picom)
- **Notifications**  : [Dunst](https://wiki.archlinux.org/index.php/Dunst) :bell: Hopscotch colors
- **Launcher**	     : [Rofi](https://github.com/davatorium/rofi)
- **File Manager**   : [PCManFM](https://wiki.archlinux.org/index.php/PCManFM)
- **Hotkeys**	     : [SXHKD](https://github.com/baskerville/sxhkd)
- **Text Editor**    : [GNU Emacs](https://www.gnu.org/software/emacs/), [Vim](https://www.vim.org/) :pencil2: Programming environments
- **Music Player**   : [MPD](https://www.musicpd.org/). [NCMPCPP](https://github.com/ncmpcpp/ncmpcpp) :musical_note: Polybar integration

## :art: Colors
### <p align="center">[Hopscotch Color Scheme](https://base16.netlify.app/previews/base16-hopscotch.html)</p>
<p align="center"><a name="top" href="#art-colors"><img src="https://github.com/miikanissi/dotfiles/blob/master/.config/gallery/base16-hopscotch.png?raw=true" alt="hopscotch-color-scheme" height="60%" width="100%"></a></p>

## :scroll: Scripts
Most of my useful shell scripts are included in [.local/bin/](https://github.com/miikanissi/dotfiles/tree/master/.local/bin).

Here are some example scripts:
- [rofi_dman.sh](https://github.com/miikanissi/dotfiles/blob/master/.local/bin/rofi_dman.sh) is a script to manage devices with rofi/dmenu. Features include mounting, unmounting, ejecting and listing devices.
- [polybar_weather.sh](https://github.com/miikanissi/dotfiles/blob/master/.local/bin/polybar_weather.sh) is a script that gets weather information from https://wttr.in/ and displays it in Polybar.
- [fe.sh](https://github.com/miikanissi/dotfiles/blob/master/.local/bin/fe.sh) is a script using fuzzy finder to find files by name, filetype and/or content.
- [screenshot.sh](https://github.com/miikanissi/dotfiles/blob/master/.local/bin/screenshot.sh) takes a screenshot of selected region and saves it in clipboard and screenshot folder.

## :wrench: Installation
To install and integrate with the system you need to checkout the arch branch and initialize submodules:

    git --work-tree $HOME --git-dir $HOME/dotfiles init
    git --work-tree $HOME --git-dir $HOME/dotfiles remote add-t \* -f origin git@github.com:miikanissi/dotfiles.git
    git --work-tree $HOME --git-dir $HOME/dotfiles checkout arch
    git --work-tree $HOME --git-dir $HOME/dotfiles submodule update --init
    git --work-tree $HOME --git-dir $HOME/dotfiles config --local status.showUntrackedFiles no

Or you can just clone the repository normally and move files in their correct location:

    git clone --recurse-submodules https://github.com/miikanissi/dotfiles.git
    cd dotfiles

Elementary cursor theme requires the following command:

    cp -R ~/.icons/elementary-cursors/elementary/ ~/.icons/

Vimix Icon Theme needs to be installed with:

    ./install.sh -a

Dependencies are not automatically installed, but a comprehensive list of packages for Arch Linux can be found at [program_list_arch.csv](https://github.com/miikanissi/dotfiles/blob/master/program_list_arch.csv).

## :purple_heart: Links / Credits
To stay up to date with me visit my [blog](https://miikanissi.com/blogindex).

Credits:
- [Lukewh](https://www.youtube.com/channel/UC7FpGodjczWY8mDV1KvP2pQ) Helpful emacs configuration guide.
- [owl4ce](https://github.com/owl4ce/dotfiles) README.md inspired by him.
- [Leeren](https://github.com/leeren) Vim configurations inspired by him.
- [LukeSmithxyz](https://github.com/LukeSmithxyz) introduced me to many different software I use.
