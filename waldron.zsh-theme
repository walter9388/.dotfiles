## modified from https://github.com/ohmyzsh/ohmyzsh/blob/306cea0945166bd0b32290c0813bf90c7dee6369/themes/fletcherm.zsh-theme with elements of https://github.com/ohmyzsh/ohmyzsh/blob/b3ba9978cc42a5031c7b68e3cf917ec2e64643bc/themes/pygmalion.zsh-theme
# Copied from old version of tonotdo's theme. LSCOLORS modified.

## prompt with no machine name
PROMPT='%{$fg_no_bold[cyan]%}%n%{$fg_no_bold[magenta]%}•%{$fg_no_bold[green]%}%3~$(git_prompt_info)%{$reset_color%}» '
## prompt with machine name
# PROMPT='%{$fg_no_bold[cyan]%}%n%{$fg[cyan]%}@%{$reset_color%}%{$fg[cyan]%}%m%{$reset_color%}%{$fg_no_bold[magenta]%}•%{$fg_no_bold[green]%}%3~$(git_prompt_info)%{$reset_color%}» '
## uncomment line below to get clock on right hand side like in original theme
# RPROMPT='[%*]'

# git theming
ZSH_THEME_GIT_PROMPT_CLEAN=""
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[yellow]%}⚡%{$fg_bold[blue]%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}|%{$fg_no_bold[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[yellow]%} ✘"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[yellow]%}✔"

# ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[yellow]%}✚"
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}★"
# ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[yellow]%}✖"
# ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[yellow]%}➜"

export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'
