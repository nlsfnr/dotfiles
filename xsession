#!/usr/bin/bash

LOW_RESOLUTION="1920x1080"
LOW_SCALE="2x2"
LOW_DPI="96"

HIGH_RESOLUTION="3840x2160"
HIGH_SCALE="1x1"
HIGH_DPI="192"

xrandr | grep -q "DP-3 connected"                               \
&& (                                                            \
    xrandr                                                      \
    --output eDP-1                                              \
        --mode $HIGH_RESOLUTION                                 \
        --scale $HIGH_SCALE                                     \
    --output DP-3                                               \
        --mode $LOW_RESOLUTION                                  \
        --scale $LOW_SCALE                                      \
        --right-of eDP-1                                        \
        --primary                                               \
    && (echo "Xft.dpi: $HIGH_DPI" | xrdb -merge)                 \
)                                                               \
|| (                                                            \
    xrandr                                                      \
    --output eDP-1                                              \
        --primary                                               \
        --mode $HIGH_RESOLUTION                                 \
        --scale $HIGH_SCALE                                     \
    && echo "Xft.dpi: $HIGH_DPI" | xrdb -merge                  \
)
