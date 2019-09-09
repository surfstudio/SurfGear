#!/bin/bash

### Copy LICENSE to all flutter packages if necessary.
### must be run from root of repository
### region FUNC

## check is directory flutter(dart) package
## $1 - input dir
function hasPubspec() {
    ls -la $1/ | grep -q pubspec.yaml
}

## check existing LICENSE
function hasPubspec() {
    ls -la $1/ | grep -q pubspec.yaml
}

### endregion

for dir in */; do
    if ! $(hasPubspec $dir) ; then
        echo "No pubspec.yaml. ${dir} is not flutter package root directory. Skipping..."
        continue
    fi
    
    if ! grep -q -f $dir/LICENSE ./license/LICENSE ; then
        echo No license in $dir. Adding new one...
        cp ./license/LICENSE $dir/LICENSE
    fi
    
done