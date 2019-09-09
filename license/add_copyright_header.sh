#!/bin/bash

### region FUNCTION

## add copyright to files .dart in dir
function addCopyright() {
    i=$1
    if ! grep -q Copyright $i; then
        echo No license in $i. Adding new one...
        cat ../license/copyright.txt $i >$i.new && mv $i.new $i
    fi
}

function addCopyrightInCurrentDir() {
    for dir in $(find . -iname *.dart); do
        addCopyright $dir
    done
}
### endregion

echo "Parameters" $1 $2
while [[ -n "$1" ]]; do # while loop starts

    case "$1" in

    -x64)
        platform=android-arm64
        ;;

    -qa)
        build_type=qa
        ;;

    -release)
        build_type=release
        ;;
    -h)
        usage
        exit
        ;;

    *)
        usage
        exit
        ;;

    esac

    shift

done

addCopyrightInCurrentDir
