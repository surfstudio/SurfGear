#!/usr/bin/env bash

apk_prefix_64=arm64-v8a
apk_prefix_v7=armeabi-v7a

platform=
build_type=release
postfix=

### FUNCTIONS
function buildApk() {
    echo Build type ${build_type}
    flutter build apk -t lib/main-${build_type}.dart --split-per-abi;
}

function cleanArtifacts() {
    echo Cleaning dir
    pwd
    cd ./build/app/outputs/apk/release/
    find . -type f -name "app-*-release.apk" -exec rm -f {} \;
    cd ../../../../..;
}

function rename() {
    cd ./build/app/outputs/apk/release/

    postfix=${build_type}
    if [[ -n  ${platform} ]]; then
        postfix=${postfix}-${platform}
    fi

    echo Postfix ${postfix} "," ${platform}
    echo Make postfix ...

    if [[ -n ${platform} ]]; then
        mv app-${apk_prefix_64}-release.apk app-${postfix}.apk

        echo app-${apk_prefix_64}-release.apk renamed to app-${postfix}.apk
    else
        mv app-${apk_prefix_v7}-release.apk app-${postfix}.apk

        echo app-${apk_prefix_v7}-release.apk renamed to app-${postfix}.apk
    fi

    ls -la
    cd ../../../../..;
}


function build() {
    buildApk && rename && cleanArtifacts
}

function usage() {
    echo "usage: build.sh [[-x64 ] [-qa] | [-release]] | [-h]]"
}

### END FUNC

echo "Parameters" $1 $2
while [[ -n "$1" ]]; do # while loop starts

        case "$1" in

            -x64 )          platform=android-arm64
                            ;;

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

build
