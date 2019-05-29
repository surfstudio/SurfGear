#!/usr/bin/env bash

build_type=release

#flutter upgrade;
#flutter clean;

### FUNCTIONS
function buildIpa() {
    echo Build type ${build_type}
    flutter build ios --release -t lib/main-${build_type}.dart --no-codesign
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

build
