#!/usr/bin/env bash

build_type=release
flavor=dev
### FUNCTIONS

function resolveFlavor() {
    if [[ ${build_type} = release ]]; then
        flavor=prod
    fi
}

function clean() {
    ./clean_ios.sh
}

function buildIpa() {
    echo Build type ${build_type}
#    flutter packages get
    flutter build ios --release --flavor ${flavor} -t lib/main-${build_type}.dart --no-codesign
}

function build() {
    buildIpa
}

function usage() {
    echo "usage: build.sh [[-qa] | [-release]] | [-h]]"
}

### END FUNC

echo "Parameters" $1 $2
while [[ -n "$1" ]]; do # while loop starts

        case "$1" in

            -qa )           build_type=qa
                            ;;

            -release )      build_type=release
                            ;;
            -h )            usage
                            exit
                            ;;

            *)              usage
                            exit
                            ;;

            esac

         shift

done

### MAIN

#todo uncomment when needed to upgrade flutter on node
#flutter upgrade;
#flutter clean;

resolveFlavor
clean
build
