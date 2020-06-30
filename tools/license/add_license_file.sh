#!/bin/bash

### Copy LICENSE to all flutter packages if necessary.
### must be run from root of repository
### region FUNC

## check is directory flutter(dart) package
## $1 - input dir
## !!!deprecated use ci task instead
function hasPubspec() {
    ls -la $1/ | grep -q pubspec.yaml
}

## check existing LICENSE
## !!!deprecated use ci task instead
function hasLicense() {
   grep -q -f $1/LICENSE ./license/LICENSE
}

### endregion

for dir in */; do
    if ! $(hasPubspec $dir) ; then
        echo "No pubspec.yaml. ${dir} is not flutter package root directory. Skipping..."
        continue
    fi
    
    if ! $(hasLicense $dir); then
        echo No license in $dir. Adding new one...
        cp ./license/LICENSE $dir/LICENSE
    fi
    
done