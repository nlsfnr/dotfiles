# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Set the keyboard layout
setxkbmap -layout us -option caps:escape

if [ -z "$(ps -a | grep "blueman-applet" | grep -v "grep")" ] ; then
    blueman-applet &
fi

export PATH=$PATH:/usr/local/go/bin
export GPG_TTY=$(tty)
. $HOME/.xsession
