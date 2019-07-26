#!/usr/bin/env bash

apk_prefix_64=arm64-v8a
apk_prefix_v7=armeabi-v7a
apk_prefix_universal=universal

platform_postfix_64=android-arm64
platform=
build_type=release
postfix=
flavor=dev

apk_path=

### FUNCTIONS

function resolveFlavor() {
    if [[ ${build_type} = release ]]; then
        flavor=prod
    fi

    apk_path=./build/app/outputs/apk/${flavor}/release/
}

function returnToParentDir() {
    cd ../../../../../..;
}

function buildApk() {
    echo Build type ${build_type}

    flutter build apk --flavor ${flavor} -t lib/main-${build_type}.dart --split-per-abi ;
}

function cleanArtifacts() {
    echo Cleaning dir
    pwd
    cd ${apk_path}
    pwd
#    rm -f "app-*-release.apk"
    find . -type f -name "app-*-release.apk" -exec rm -f {} \;
    returnToParentDir
}

function rename() {
    cd ${apk_path}

    postfix=${build_type}

    echo Postfix ${postfix} "," ${platform}
    echo Make postfix ...

    if [[ -n ${platform} ]]; then
        mv app-${flavor}-${apk_prefix_64}-release.apk app-${postfix}-${apk_prefix_64}.apk

        echo app-${apk_prefix_64}-release.apk renamed toapp-${postfix}-${apk_prefix_64}.apk
    else
        mv app-${flavor}-${apk_prefix_v7}-release.apk app-${postfix}-${apk_prefix_v7}.apk

        echo app-${apk_prefix_v7}-release.apk renamed to app-${postfix}-${apk_prefix_v7}.apk
    fi

    ls -la
    returnToParentDir
}


function build() {
    resolveFlavor && buildApk && rename && cleanArtifacts
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

#flutter upgrade;
#flutter clean;

build
