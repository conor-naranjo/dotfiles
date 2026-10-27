#!/bin/bash

# set big monitor as primary
xrandr --output DisplayPort-2 --primary --below DisplayPort-1

exec i3
