# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Terminal colors
force_color_prompt=yes
[ -n "$force_color_prompt" ] && ([ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null && color_prompt=yes || color_prompt=) && \
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)")\$ ' || \
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 "(%s)")\$ '
unset color_prompt force_color_prompt

# Enable color support of ls
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
alias py8=python3.8
alias py10=python3.10
alias pip="python3 -m pip"
alias g=git
alias gst="git status"
alias _brightness="xrandr --output eDP-1 --brightness"
alias _suspend="systemctl suspend"
alias v=nvim
alias vi=nvim
alias vim=nvim
alias va="if [ -d .venv ]; then . .venv/bin/activate; else [ -d venv ] && . venv/bin/activate; fi"
alias ffind="find . -type f -wholename"
alias tree="tree -I '__pycache__|node_modules'"

alias gpt="gptx q"  # Start new conversation with GPT-4
alias gptc="gptx q --conversation latest"  # Continue conversation
alias gptbash="gptx q --run --prompt bash"
alias gb="gptx q --run --prompt bash"
alias gptr="gptx repeat"  # Repeat last prompt

alias plan="nvim ~/.plan.md"
alias lr="cd ~/L/ && va"

# NVM = Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR=nvim
