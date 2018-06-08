# m3u-creator.sh create a M3U playlist from a directory
#
# Examples:
#   - m3u-creator.sh -R -f "! -iname *.pls -and ! -iname *.m3u" -o playlists/ -- ~/Music
cf_target_dir=$(pwd)
cf_output_dir=
cf_recursive="-maxdepth 0"
cf_prompt_to_overwrite=false
cf_filters="-name '*'"


usage() {
    echo "Usage: $0 [-Rra] [--help] [-f FILTERS] -o OUTPUT_DIR [--] [INPUT_DIR]"
}

parse_params() {
    while [ $# -gt 0 ]; do
        case $1 in
            -R|-r)
                cf_recursive=;;
            -a)
                # prompt before overwrite
                cf_prompt_to_overwrite=true;;
            -f)
                # -f requires a parameter
                shift
                [ $# -gt 0 ] && cf_filters=$1 || return 1;;
            -o)
                # -o requires a parameter
                shift
                [ $# -gt 0 ] && cf_output_dir=$1 || return 1;;
            --help)
                usage; exit 0;;
            --)
                shift
                cf_target_dir="$@"
                shift $#;;
            *)
                # if it is the last parameter and is not recognized,
                # we guess it must be the DIR parameter.
                [ $# -eq 1 ] && cf_target_dir="$1" || return 1;;
        esac
        shift
    done

    # -o OUTPUT_DIR required
    [ -n "$cf_output_dir" ] || return 1

    [ -d "$cf_target_dir" ] || { echo "$cf_target_dir is not a directory." 1>&2; exit 1; }
    [ -d "$cf_output_dir" ] || { echo "$cf_output_dir is not a directory." 1>&2; exit 1; }
}

walk_dir() {
    find "$1" $cf_recursive -type d
}

browse_dir() {
    find "$1" -maxdepth 1 -type f # \( ${cf_filters} \)
}

parse_params "$@" || { usage 1>&2; exit 1; }
walk_dir "$cf_target_dir" | while read l; do\
    (
        # if there is files found/ are matching is the dir, we store them
        content=$(browse_dir "$l")\
            && output_dir="$cf_output_dir/$l"\
            && [ -n "$content" ]\
                && mkdir -p "$output_dir"\
                && (
                    echo "$content" > "$output_dir/$(basename "$l").m3u"\
                         || echo "fail ($l)" 1>&2
                )
    );
done

