#!/usr/bin/bash

# RESOLUTION="3840x2160"
RESOLUTION="1920x1080"
SCALE="1x1"
DPI="96"

echo "Xft.dpi: $DPI" | xrdb -merge

xrandr | grep -q "DP-3 connected"   \
&& xrandr                           \
    --output eDP-1                  \
        --mode $RESOLUTION          \
        --scale $SCALE              \
    --output DP-3                   \
        --primary                   \
        --mode $RESOLUTION          \
        --right-of eDP-1            \
        --scale $SCALE              \
|| xrandr                           \
    --output eDP-1                  \
        --primary                   \
        --mode $RESOLUTION          \
        --scale $SCALE
