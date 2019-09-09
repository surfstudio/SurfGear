#!/bin/bash
### region PARAMS
pattern=*.dart
pathToCopyright=./license/copyright.txt
### endregion

### region FUNCTION

## add copyright to files .dart in dir
function addCopyright() {
    i=$1
    if ! grep -q Copyright $i; then
        echo No license in $i. Adding new one...
        cat ${pathToCopyright} $i >$i.new && mv $i.new $i
    else 
        echo $i already has a license. Skiping...
    fi
}

function addCopyrightInCurrentDir() {
    for dir in $(find . -iname ${pattern}); do
        addCopyright $dir
    done
}

function usage() {
    echo "usage: $0 [-p pattern for search ] [-cp | --copyright-path path to copyright]| [-h]]"
}
### endregion

echo Parameters $@
while [ -n "$1" ] 
do
    case "$1" in
        -p | --pattern ) 
            shift
            pattern=$1
            ;;
        -cp | --copyright-path )
            shift
            pathToCopyright=$1
            ;;
        *) 
            usage
            exit
            ;;
    esac
    shift
done


addCopyrightInCurrentDir
