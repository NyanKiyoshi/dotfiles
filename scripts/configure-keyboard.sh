#!/bin/sh
setxkbmap -model pc104 -option 'grp:shift_together_toggle,ctrl:nocaps' 'us' -variant 'altgr-intl'
xkbcomp ${HOME}/configurations/xkb/gb-altgr-intl.xkb $DISPLAY
xinput --set-prop 10 'libinput Accel Speed' 1

