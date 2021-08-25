#!/bin/bash

unclutter -grab &
exec redshift &
exec xmodmap ~/.Xmodmap &
#exec feh --bg-tile /home/conor/backgrounds/spiration-dark.png &
feh --bg-fill $HOME/backgrounds/pixel-city.jpg &
exec i3
