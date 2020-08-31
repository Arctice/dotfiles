LC_PAPER="en_GB.UTF-8"
LC_MEASUREMENT="en_GB.UTF-8"

# Prepend my home bin directories to the path if not there already.

for p in $HOME/usr/bin $HOME/bin
do
    if [[ :"$PATH": != *:"$p":* && -d "$p" ]]
    then PATH="$p:$PATH"
    fi
done

export EDITOR="emacs -nw"
export LESS="-i -j.49 -M -R"
export PAGER=less

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it

shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=200000
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]\[$(tput setaf 45)\]<\D{%H:%M}>\[$(tput sgr0)\]\[\033[01;34m\]\w\[\033[00m\] '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

alias l='ls -alvh'
cd() { builtin cd "$@" && l; }

# no bells
if [ -n "$DISPLAY" ]; then
  xset b off
fi

# completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


