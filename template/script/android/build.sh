#!/usr/bin/env bash

apk_prefix_64=arm64-v8a
apk_prefix_v7=armeabi-v7a
apk_prefix_universal=universal

platform_postfix_64=android-arm64
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

function cleanArtifacts() {
    cd ./build/app/outputs/apk/release/
    find . -name "app-*-release.apk" -delete
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

    if [[${platform}=${platform_postfix_64}]]; then
        mv app-${apk_prefix_64}-release.apk app-${postfix}.apk
    else
        mv app-${apk_prefix_universal}-release.apk app-${postfix}.apk
    fi

    ls -la

    echo "Restore release build if it exist"
    if [[ ${build_type}=release ]]; then
         mv app-universal-release.apk app-release.apk
    fi
    ls -la
    cd ../../../../..;
}


function build() {
    buildApk
    rename
    cleanArtifacts

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
