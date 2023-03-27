# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Terminal colors
force_color_prompt=yes
[ -n "$force_color_prompt" ] && ([ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null && color_prompt=yes || color_prompt=) && \
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ' || \
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
unset color_prompt force_color_prompt

# Enable color support of ls and also add handy aliases
[ -x /usr/bin/dircolors ] && \
    test -r ~/.dircolors && \
    eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

# Enable programmable completion features
! shopt -oq posix && [ -f /usr/share/bash-completion/bash_completion ] && \
        source /usr/share/bash-completion/bash_completion

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

# Aliases
alias ls='ls --color=auto'
alias l="ls -lh"
alias ll="l -a"
alias python=python3
alias py=python3
alias pip=pip3
alias g=git
alias gst="git status"
alias _brightness="xrandr --output eDP-1 --brightness"
alias _suspend="systemctl suspend"
alias _reconnect="sudo ip link set wlp59s0 down && sudo ip link set wlp59s0 up"
alias vim=nvim
alias v=nvim
alias va="if [ -d .venv ]; then . .venv/bin/activate; else [ -d venv ] && . venv/bin/activate; fi"
