#!/bin/sh

main() {
    if [[ -z "$(pgrep $1)" ]]; then
        exec $@
        return 0
    fi
    return 1
}
main $@

