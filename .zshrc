# ~/.zshrc: executed by zsh for non-login shells.


# Set scale factor for X11
WINIT_X11_SCALE_FACTOR=1

# If not running interactively, don't do anything
case $- in
    *i*) ;;         # if interactive, do nothing
      *) return;;   # if anything else, return
esac

if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if command -v fzf 2>&1 >/dev/null; then
    export FZF_CTRL_R_OPTS="
      --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
      --color header:italic
      --header 'Press CTRL-Y to copy command into clipboard'"
    source <(fzf --zsh)
fi

# starship
eval "$(starship init zsh)"

# funcs
cheat() { curl cheat.sh/$1; }
weather() {
    if [ -z "$1" ]; then
        curl wttr.in
    else
        curl wttr.in/$1
    fi
}
weather2() {
    if [ -z $1 ]; then
        curl v2.wttr.in/$1
    else
        curl v2.wttr.in
    fi
}

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

# See zsh(1) for more options
HISTCONTROL=ignoredups   # ignore duplicate lines
HISTFILE=~/.zsh_history
setopt appendhistory     # append to the history file, don't overwrite it
setopt share_history     # share history among running sessions
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

