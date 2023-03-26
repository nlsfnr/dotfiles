xrdb -merge ~/.Xresources

if xrandr | grep -q "DP-3 disconnected"; then
    xrandr \
        --output eDP-1 \
            --primary \
            --scale 1x1 \
            --mode 1920x1080;
else
    xrandr \
        --output eDP-1 \
            --mode 1920x1080 \
            --scale 1x1 \
        --output DP-3 \
            --primary \
            --mode 1920x1080 \
            --right-of eDP-1 \
            --scale 1x1;
fi
