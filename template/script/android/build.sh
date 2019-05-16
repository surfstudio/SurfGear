#!/usr/bin/env bash

platform=
build_type=release
postfix=${build_type}

#flutter upgrade;
flutter clean;

while [[ -n "$1" ]]; do # while loop starts

    case "$1" in

    -x64) platform=android-arm64;;

    -qa) build_type=qa ;; # Message for -b option

    -release) build_type=qa ;; # Message for -c option

    *) echo "Option $1 not recognized" ;; # In case you typed a different option other than a,b,c

    esac

    shift

done

function buildApk() {
    if [[ -z  ${platform} ]]; then
        flutter build apk --release -t lib/main-${build_type}.dart;
    else
        flutter build apk --release -t lib/main-${build_type}.dart --target-platform ${platform};
    fi
}

function rename() {

    if [[ -n  ${platform} ]]; then
        postfix=${postfix}-${platform}
    fi

    cd ./build/app/outputs/apk/release/
    mv app-release.apk app-${postfix}.apk
    ls -la
    cd ../../../../..;
}

buildApk
rename