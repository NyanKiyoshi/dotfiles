#!/bin/sh
# mdp-playlist-launcher.sh:
#   Create a new MPC queue (by clearing it) containing every passed playlist.
#   It only supports playlists ending by ".m3u" and ".pls".


# default MPC's executable path (use export to override)
MPC_PATH=${MPC_PATH:=/usr/bin/mpc}


add_input_to_playlist() {
    # clear the playlist
    $MPC_PATH clear

    while read l; do
        [ -n "$l" ] && $MPC_PATH add "$l"
    done

    $MPC_PATH play
}


handle_m3u_playlist() {
    cat "$@" | sed -e '/^#/D'
}


handle_pls_playlist() {
    grep --no-filename '^File[0-9]*' "$@" | sed -e 's/^File[0-9]*=//'
}


process_files() {
    while [ $# -gt 0 ]; do
        case $1 in
            *.m3u)
                handle_m3u_playlist "$@"
                ;;
            *.pls)
                handle_pls_playlist "$@"
                ;;
        esac

        # process the next file from the queue
        shift
    done
}


[ $# -gt 0 ] || { echo "Usage: $0 PLAYLIST..."; exit 1; }

process_files "$@" | add_input_to_playlist

