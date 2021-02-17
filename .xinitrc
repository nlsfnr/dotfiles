xrdb -merge ~/.Xresources

if xrandr | grep -q "DP-1-3"; then
    xrandr --dpi 440 \
        --output eDP-1-1 \
            --mode 1920x1080 \
            --scale 1x1 \
        --output DP-1-3 \
            --mode 1920x1080 \
            --scale 1x1 \
            --right-of eDP-1-1
fi

blueman-applet &
# exec i3
