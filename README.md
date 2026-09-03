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

## herdr (replacing tmux)

`herdr/config.toml` is symlinked to `~/.config/herdr/config.toml`. Only that file
is symlinked — herdr keeps machine-local state beside it (`session.json`,
sockets, logs) that stays out of the repo. Validate with `herdr config check`,
apply to a running server with `prefix+shift+r`.

Prefix is still `ctrl+b`. Bindings carried over from `.tmux.conf`:

| tmux                        | herdr                                    |
| --------------------------- | ---------------------------------------- |
| `prefix \|` split sideways   | `prefix \|` (or `prefix v`)               |
| `prefix -` split down       | `prefix -`                               |
| `prefix h/j/k/l` resize     | `prefix h/j/k/l` — via the same plugin     |
| `prefix m` zoom             | `prefix m` (or `prefix z`)                |
| `prefix r` reload config    | `prefix shift+r`                          |
| `ctrl h/j/k/l` pane nav     | `ctrl h/j/k/l` — via the herdr-splits plugin |
| copy-mode-vi, `v` / `y`     | `prefix [`, then `v` / `y` — built in     |

`ctrl+hjkl` navigation and `prefix+hjkl` resize both come from
[herdr-splits.nvim](https://github.com/lmilojevicc/herdr-splits.nvim), installed
on both sides and pinned to the same commit:

```bash
herdr plugin install lmilojevicc/herdr-splits.nvim   # herdr side
```

The Neovim side is `nvim/lua/plugins/herdr.lua`, loaded only when
`HERDR_ENV=1`; `nvim/lua/plugins/tmux.lua` is correspondingly gated on `$TMUX`
so vim-tmux-navigator and herdr-splits never both map `ctrl+hjkl`. herdr core
has no per-direction resize action, so the plugin is what makes the tmux-style
`prefix+hjkl` resize possible at all.

`<C-hjkl>` is deliberately **not** mapped in `lua/config/keymaps.lua`. It used
to be hardcoded to `:TmuxNavigate*`, which silently did nothing inside herdr —
vim-tmux-navigator isn't loaded there, so the command didn't exist. Each plugin
now owns those keys under its own guard, so they follow the environment.

In navigate mode (`prefix+g`), `j`/`k` move down/up the workspace list as well
as the arrows. Pane up/down are `ctrl+j`/`ctrl+k` there, since a plain `j`/`k`
collision is resolved by herdr in favour of the workspace binding.

Things that needed no config, because herdr does them natively:

- **Session save/restore** — replaces tmux-resurrect + tmux-continuum. The
  server owns the session and writes `session.json` continuously; there is no
  save keybinding. Detaching (`prefix q`) leaves every process running. A server
  restart replays workspaces, tabs, panes, cwds and layout as fresh shells.
  Note the asymmetry: **detaching keeps processes running, rebooting does not** —
  after a reboot panes return as fresh shells in the right directories, so nvim
  and dev servers are gone. Claude conversations do resume, but only because of
  `herdr integration install claude`, which `resume_agents_on_restore` depends
  on to get session IDs. Check it with `herdr integration status`.
- **Claude Code pane titles** — `.tmux.conf` needed a regex to work around
  Claude overwriting its process name with its version number. herdr exposes
  the stripped terminal title directly as `terminal_title_stripped`.

### Worktree-aware splits

`prefix+|` and `prefix+-` run `herdr/bin/split-worktree.sh` rather than herdr's
built-in split. herdr's `new_cwd = "follow"` inherits the focused pane's *live*
cwd, not the directory the pane was spawned in. A long-running agent's cwd can
drift out of the worktree during a session — Claude Code's process cwd tracks
its persistent shell, so a `cd` anywhere in the session moves it for good — and
a split then lands wherever that process ended up.

Plain `claude` does not itself leave a worktree; this is drift acquired during
a session, so a Claude pane that has never been moved is unaffected.

No `new_cwd` policy can express "this workspace's worktree root", so the script
resolves it from `herdr workspace list` and passes an explicit `--cwd`. Outside
a worktree workspace it falls back to the pane cwd herdr would have used, and
with no context at all it still issues a plain split.

`prefix+v` / `prefix+shift+v` stay bound to the raw built-in splits as an escape
hatch if that script is ever missing.

### Plugins

| plugin | key | what |
| ------ | --- | ---- |
| [herdr-splits](https://github.com/lmilojevicc/herdr-splits.nvim) | `ctrl+hjkl` / `prefix+hjkl` | navigate + resize, seamless with nvim splits |
| [reviewr](https://github.com/persiyanov/herdr-reviewr) | `prefix+r` | code review sidebar — comment on the agent's diff, send it back |

reviewr needs the pane's cwd to be a git repo, and `gh` authenticated for its PR
tab. Its own settings live in
`herdr/plugins/persiyanov.reviewr/config.toml`, symlinked to
`~/.config/herdr/plugins/config/persiyanov.reviewr/config.toml`. herdr's own
`config.toml` never reaches that file.

`auto_open = false` is set there. herdr fires a `worktree.created` event and
reviewr listens for it, so by default a review pane appears on every new
worktree. Open it with `prefix+r` instead.

Careful with that file: one unknown key or invalid value makes the whole file
invalid, and reviewr then applies none of it. Check a change with
`~/.config/herdr/plugins/github/*reviewr*/bin/herdr-reviewr --resolve-plugin-config`.

`prefix+r` was freed by unbinding `resize_mode`, which `prefix+hjkl` makes
redundant. Restore it in `herdr/config.toml` if you miss it.

### iTerm2: keyboard dead after detach

herdr 0.8.0 enables all kitty-keyboard flags on detach and relies on a stack pop
to undo it, which iTerm2 ignores — so keys come back as escape sequences and the
terminal looks broken. The `herdr` wrapper function in `.zshrc` clears the flags
after the client exits. If a client is killed rather than detached, run
`fixterm`.

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
