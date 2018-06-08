#!/bin/sh

# takes the parent directory of this scripts as being the source files
source_path=$(realpath $(dirname $(realpath $0))/..)

# files to ignore (IFS)
ignores='. .. helpers'

# installation target (user's home)
target_path=$HOME


# checks if given file is marked as ignored
is_to_ignore() {
    for ignore_file in $ignores; do
        [[ "$file" == "$ignore_file" ]] && return 0
    done

    return 1
}


# links file/ dir to home as symbolic link
# ignores existing targets
link_file() {
    file=$1
    target_file=${target_path}/${file}

    if [[ -f $target_file ]]; then
        ln -vs "${source_path}/${file}" "$target_file"
    else 
        echo "!! Skipped $target_file already exists." >&2
    fi
}


# process every source file and link them the user's home dir
main() {
    for file in $(ls -1a $source_path); do
        is_to_ignore $file && continue
        link_file $file
    done
}


main

