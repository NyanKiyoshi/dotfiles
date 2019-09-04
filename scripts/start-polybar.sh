killall polybar

CFG_FILE="$HOME/.config/polybar/config"

MAIN_MONITOR=HDMI-0
SECONDARY_MONITOR=DP-1

MONITOR=$MAIN_MONITOR polybar top -r -c "$CFG_FILE" &
MONITOR=$SECONDARY_MONITOR polybar secondary-top -r -c "$CFG_FILE" &

