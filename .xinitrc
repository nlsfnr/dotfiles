xrdb -merge ~/.Xresources

if xrandr | grep -q "DP-1-3 disconnected"; then
    xrandr \
        --output eDP-1-1 \
            --primary \
            --scale 1x1 \
            --mode 1920x1080;
    echo "Single monitor setup"
else
    xrandr \
        --output eDP-1-1 \
            --mode 1920x1080 \
            --scale 1x1 \
        --output DP-1-3 \
            --primary \
            --mode 1920x1080 \
            --right-of eDP-1-1 \
            --scale 1x1;
    echo "Dual monitor setup"
fi

blueman-applet
