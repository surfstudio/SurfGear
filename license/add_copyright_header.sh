#!/bin/bash
### region PARAMS
copywriter=
pattern=*.dart
### endregion

### region FUNCTION

## add copyright to files .dart in dir
function addCopyright() {
    i=$1
    if ! grep -q Copyright $i; then
        echo No license in $i. Adding new one...
        cat ./license/copyright.txt $i >$i.new && mv $i.new $i
    fi
}

function addCopyrightInCurrentDir() {
    for dir in $(find . -iname ${pattern}); do
        addCopyright $dir
    done
}

function usage() {
    echo "usage: $0 [-p pattern for search ] [--copywriter name of copywriter]| [-h]]"
}
### endregion

addCopyrightInCurrentDir
