#!/bin/sh
#
# mpc-spotify-next-track.sh switch musics (next/prev) from mpc or spotify,
# depending whether mpc is paused or playing.
#
# If mpc is currently playing music, the command will be sent to mpc.
# To spotify otherwise.
#
# ---
# Usage: [-prev]
#   -prev: switch to the previous song, instead of the next one.
MPC=mpc

is_mpc_active() {
    $MPC | grep -owiFq '[playing]'
}

mpc_next() {
    $MPC next
}

mpc_prev() {
    $MPC prev
}

# Sends a command to spotify through dbus
# Note PlayPause and Stop are available as well.
# FIXME: provide a list of commands.
spotify_send() {
    dbus-send \
        --print-reply \
        --dest=org.mpris.MediaPlayer2.spotify \
        /org/mpris/MediaPlayer2 $@
}

spotify_next() {
    spotify_send org.mpris.MediaPlayer2.Player.Next
}

spotify_prev() {
    spotify_send org.mpris.MediaPlayer2.Player.Previous
}

command=$([ test $1 == -prev ] && echo prev || echo next)

is_mpc_active && (mpc_$command) || (spotify_$command)

