#!/usr/bin/env bash

platform=
build_type=release
postfix=

#flutter upgrade;
#flutter clean;

### FUNCTIONS
function buildApk() {
    echo Build type ${build_type}
    if [[ -z  ${platform} ]]; then
        flutter build apk --release -t lib/main-${build_type}.dart;
    else
        flutter build apk --release -t lib/main-${build_type}.dart --target-platform ${platform};
    fi
}

function rename() {
    cd ./build/app/outputs/apk/release/

    #save current release build
    cp app-release.apk app-release-temp.apk
    
    postfix=${build_type}
    if [[ -n  ${platform} ]]; then
        postfix=${postfix}-${platform}
    fi

    echo Postfix ${postfix} "," ${platform}
    mv app-release.apk app-${postfix}.apk
    echo Make postfix ...
    ls -la
    
    if [[ ${build_type}=release ]]; then
         mv app-release-temp.apk app-release.apk
    fi
    echo "Restore release build if it exist"
    ls -la

    cd ../../../../..;
}

function build() {
    buildApk
    rename
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

build
