# .dotfiles

# Install script

In bash terminal make install script executable (`chmod +x install.sh`), then run as superuser with

```bash
sudo ./install
```

## OLD (replaced with LazyVim installation)

After this, there are a few packet managers that need things to happen:

1. Packer (neovim package manager): Open up `~/.config/nvim/lua/vim_stuff/packer.lua` and the source the file (`:so`) and then run (`:PackerSync`).
2. Mason (neovim LSP manager): In neovim, open Mason (`:Mason`) and make sure everything is installed.
3. Tmux: tmux should source the `.tmux.conf` file automatically, but if not, run `tmux source ~/.tmux.conf`. Then, to install plugins, open tmux and run `prefix + I` and a popup should come up when things have been installed.

## Tutorials

Most of the zsh, neovim and tmux stuff was take from this guy who made a youtube video on each subject:

- [zsh](https://youtu.be/CF1tMjvHDRA)
- [nvim](https://youtu.be/vdn_pKJUda8)
- [tmux](https://youtu.be/U-omALWIBos)

I also threw in a bit of stuff I learnt from ThePrimeagen ([his .dotfiles are here](https://github.com/ThePrimeagen/.dotfiles)).

# Fonts

I stole this script from [here](https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0?permalink_comment_id=4005789#gistcomment-4005789) in order to install a bunch of different nerdfonts.

Install the fonts by running the fonts script:

```bash
./fonts
```

I generally use DroidSansMonoNF (download here if you want it only: `https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/DroidSansMono.zip`).

You can then do something like `setfont ~/.local/share/fonts/{choose font from here}`.

If using WSL however, it's a lot more manual to get nerdfonts to work... I did [this](https://superuser.com/a/1634999):

```
Install "Sauce Code Pro Nerd Font" https://www.nerdfonts.com/font-downloads Unpack -> Open "whatever font you like".ttf and install. Check the installed font in a directory "C:\Windows\Fonts".
2.1) Open "Powershell", "Ubuntu" (or another WSL-distro), then right-click -> Properties -> Font -> Change font to "Sauce Code Pro Nerd Font".

2.2) If you use Windows Terminal. Open it -> "Ctrl+," -> find an attribute "profiles{...} -> defaults{...} -> add to "defaults" an attribute "fontFace": "SauceCodePro Nerd Font" to apply the font to all profiles or choose a profile from "list" and type the same to apply only to the given profile (e.x. "Cascadia Code PL" for Powershell, "SauseCode Pro Nerd Font" for Ubuntu).

Optional. Open VSCode -> Ctrl+, -> fontFamily: type "SauseCodePro Nerd Font" before other fonts.

You can do this with other fonts, but they need to support a powerline glyphs, e.g. "Mononoki" font.
```

# Docker Validation

I build demo ubuntu setup with

```bash
docker build -t ubuntu-setup .
```

then run with

```bash
docker run -ti ubuntu-setup
```
