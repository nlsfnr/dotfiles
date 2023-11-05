#!/usr/bin/bash

function add_to_path() {
  if [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$PATH:$1"
  fi
}

add_to_path "$HOME/.local/bin"
add_to_path "/usr/local/go/bin"
add_to_path "$HOME/.cargo/bin"

# Set keyboard layout and map caps lock to escape
setxkbmap -layout us,de
setxkbmap -option 'grp:win_space_toggle'
setxkbmap -option caps:escape

# Run the blueman-applet if it's not already running
! pgrep -x "blueman-applet" > /dev/null && \
    blueman-applet &

# Add the GitHub SSH key to the ssh-agent
[ -f "$HOME/.ssh/github" ] && \
    eval $(ssh-agent) > /dev/null && \
    ssh-add -q ~/.ssh/github

# Configure xsession
[ -f "$HOME/.xsession" ] && \
    source "$HOME/.xsession"
