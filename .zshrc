# ~/.zshrc: executed by zsh for non-login shells.


# Set scale factor for X11
WINIT_X11_SCALE_FACTOR=1

# If not running interactively, don't do anything
case $- in
    *i*) ;;         # if interactive, do nothing
      *) return;;   # if anything else, return
esac

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# starship
eval "$(starship init zsh)"

# helper functions
cheat() { curl cheat.sh/$1; }
weather() { curl wttr.in; }
weather2() { curl v2.wttr.in; }
alias prettyjson="python3 -m json.tool"
alias mpv-audio="mpv --no-audio-display"
alias mpv-audio-y="mpv --ytdl-format='bestaudio/best'"
alias mpv-video-y="mpv --ytdl-format='bestvideo[height<=?720]+bestaudio/best'"

# goto to fuzzy dir
kek() {
    if [ -z $1 ]; then
        SOURCE_DIR=$HOME
    else
        SOURCE_DIR=$1
    fi
    TEMP_DIR=$(find "$SOURCE_DIR" -type d | fzf)
    if [ "$TEMP_DIR" != "" ]; then
        cd $TEMP_DIR
    fi
}

# edit fuzzy file
alias vk='TEMP_DIR=$(find "." -type f | fzf); [ "$TEMP_DIR" = "" ] || nvim $TEMP_DIR'

# See zsh(1) for more options
HISTCONTROL=ignoredups   # ignore duplicate lines
HISTFILE=~/.zsh_history
setopt appendhistory     # append to the history file, don't overwrite it
HISTSIZE=1000            # history command size
SAVEHIST=2000            # history file size

# check the window size after each command and update LINES and COLUMNS
# setopt checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# setopt globstar

zstyle ':completion:::*:default' menu no select

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# enable programmable completion features
autoload -Uz compinit
compinit

# Source files from local directory
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Load Cargo environment if it exists
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

