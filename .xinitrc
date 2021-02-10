xrdb -merge ~/.Xresources

xrandr --dpi 440 \
    --output eDP-1-1 \
        --mode 1920x1080 \
        --scale 1x1 \
    --output DP-1-3 \
        --mode 1920x1080 \
        --right-of eDP-1-1

exec i3
