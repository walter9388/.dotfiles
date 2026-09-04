# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
ZSH_THEME="miloshadzic"
ZSH_THEME="fletcherm"
ZSH_THEME="pygmalion"
ZSH_THEME="custom_fletcherm"
# use the custom theme below, can be found .dotfiles and needs to be put in .oh-my-zsh/custom/themes/waldron.zsh-theme
ZSH_THEME="waldron"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
docker
zsh-autosuggestions
zsh-syntax-highlighting
web-search
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



# ZSH_THEME="miloshadzic"

# Dependancies You Need for this Config
# zsh-syntax-highlighting - syntax highlighting for ZSH in standard repos
# autojump - jump to directories with j or jc for child or jo to open in file manager
# zsh-autosuggestions - Suggestions based on your history

# Initial Setup
# mkdir -p "$HOME/zsh/.zsh"
# git submodule add https://github.com/sindresorhus/pure.git "$HOME/zsh/pure"
# Setup Alias in $HOME/zsh/aliasrc

# Enable colors and change prompt:
#autoload -U colors && colors
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# source ~/.dotfiles/.zsh/agnoster.zsh-theme


# Custom Variables
export VISUAL=vim
export EDITOR="$VISUAL"

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
setopt appendhistory

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

## Custom ZSH Binds
#bindkey '^ ' autosuggest-accept

## Load aliases and shortcuts if existent.
#[ -f "$HOME/zsh/aliasrc" ] && source "$HOME/zsh/aliasrc"

## Load ; should be last.
#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
#source /usr/share/autojump/autojump.zsh 2>/dev/null

alias vim="nvim"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# # pnpm
# export PNPM_HOME="/home/waldron/.local/share/pnpm"
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# # pnpm end

# -----------------------------------------------------------------------------
# herdr (terminal workspace manager — replacing tmux)
# -----------------------------------------------------------------------------
if whence -p herdr &>/dev/null; then
  _herdr_bin=$(whence -p herdr)

  # CLI tab-completion. `herdr completion zsh` emits ~1700 lines, so cache it
  # and only regenerate when the binary changes rather than eval-ing on every
  # shell start. Sourced rather than autoloaded because the generated script
  # self-registers with `compdef`, which needs the compinit above to have run.
  _herdr_comp="$HOME/.cache/zsh/completions/_herdr"
  if [[ ! -f "$_herdr_comp" || "$_herdr_bin" -nt "$_herdr_comp" ]]; then
    mkdir -p "${_herdr_comp:h}"
    "$_herdr_bin" completion zsh >| "$_herdr_comp"
  fi
  source "$_herdr_comp"
  unset _herdr_comp _herdr_bin

  # iTerm2 detach fix (herdr 0.8.0).
  # On detach herdr sends CSI = 15 u, which turns on every kitty-keyboard
  # progressive-enhancement flag, then relies on CSI < 1 u popping the keyboard
  # stack to undo it. iTerm2 doesn't honour that pop, so the flags stay live and
  # every keypress arrives as a CSI-u escape sequence: the shell looks dead and
  # the screen fills with junk. Zero the flags outright instead of trusting the
  # stack. herdr does correctly restore mouse, bracketed paste and alt-screen,
  # so this only needs to touch the keyboard protocol.
  herdr() {
    command herdr "$@"
    local ret=$?
    if [[ -t 1 ]]; then
      # All three mechanisms, in this order, so the terminal lands on flags=0
      # whichever subset it actually implements — no need to know which.
      printf '\033[<u'        # pop herdr's stack entry
      printf '\033[=0;1u'     # set current flags to 0
      printf '\033[>0u'       # push a flags=0 entry
      printf '\033[?1l\033>'  # normal cursor keys, numeric keypad
    fi
    return $ret
  }

  # Escape hatch for when a herdr client is killed rather than detached, or any
  # other TUI leaves the terminal wedged.
  fixterm() {
    printf '\033[<u\033[=0;1u\033[>0u'                          # keyboard protocol
    printf '\033[?1000l\033[?1002l\033[?1003l\033[?1006l\033[?1015l'  # mouse reporting
    printf '\033[?2004l\033[?1004l\033[?1049l\033[?25h\033[?7h\033>'  # paste, focus, alt-screen, cursor
    stty sane
  }
fi

# -----------------------------------------------------------------------------
# Java / Scala
# -----------------------------------------------------------------------------
# Homebrew's openjdk is keg-only, so macOS's /usr/libexec/java_home never sees
# it and `java` falls through to the Apple stub, which reports "Unable to locate
# a Java Runtime". Point JAVA_HOME at the JDK and put it first on PATH.
# JDK 17, not the newer openjdk, because the sbt projects here are Scala 2.13.
# Metals (the Scala LSP, via nvim-metals) needs this too.
if [ -d /opt/homebrew/opt/openjdk@17 ]; then
  export JAVA_HOME=/opt/homebrew/opt/openjdk@17
  export PATH="$JAVA_HOME/bin:$PATH"
fi
