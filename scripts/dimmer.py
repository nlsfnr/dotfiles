#!/usr/bin/env python3
import os
import cv2
import numpy as np



def set_brightness(value):
    value = float(value)
    value = min(1, value)
    value = max(0, value)
    os.system(f'xrandr --output eDP-1-1 --brightness {value}')


def get_camera_brightness():
    try:
        cap = cv2.VideoCapture(0)
        means = []
        for _ in range(3):
            ret_val, img = cap.read()
            if not ret_val:
                raise ValueError('Could not read webcam image')
            means.append(img.mean())
    finally:
        cap.release()
    v = np.mean(means)
    v /= 256
    print('Brightness is', v)
    return v



set_brightness(get_camera_brightness())
