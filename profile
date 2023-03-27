export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/go/bin"
export PYTHONDONTWRITEBYTECODE="1"

# Set keyboard layout and map caps lock to escape
setxkbmap -layout us,de
setxkbmap -option 'grp:alt_shift_toggle'
setxkbmap -option caps:escape

# Run the blueman-applet if it's not already running
[ -z "$(ps -a | grep "blueman-applet" | grep -v "grep")" ] && \
    blueman-applet &> /dev/null

# Set the Cargo environment variables
[ -f "$HOME/.cargo/env" ]  && \
    source "$HOME/.cargo/env" &> /dev/null

# Add the GitHub SSH key to the ssh-agent
[ -f "$HOME/.ssh/github" ] && \
    eval $(ssh-agent) > /dev/null && \
    ssh-add -q ~/.ssh/github > /dev/null

# Configure xsession
[ -f "$HOME/.xsession" ] && \
    source "$HOME/.xsession" &> /dev/null
