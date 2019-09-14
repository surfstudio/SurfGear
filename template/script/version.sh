#!/usr/bin/env bash

# todo change to needed version of Flutter
# list of versions: flutter version
current_version=v1.7.8+hotfix.3 

# FUNC

function checkoutVersion() {
    flutter version ${current_version}
}

function checkoutChannel() {
    flutter channel stable
}

checkoutVersion
checkoutChannel