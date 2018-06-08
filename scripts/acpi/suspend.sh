#!/bin/sh
SOURCE_DIR=$(dirname $0)

# check if pm-suspend is available. Otherwise, use systemd.
which pm-suspend > /dev/null 2>/dev/null

if [ $? -eq 0 ]; then
    SUSPEND_CMD="pm-suspend"
else
    SUSPEND_CMD="systemctl suspend"
fi

sh $SOURCE_DIR/disableWakeups.sh > /dev/null
$SUSPEND_CMD

