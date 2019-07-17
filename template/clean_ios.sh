#!/usr/bin/env bash
flutter clean
cd ios/
pod cache clean --all
xcodebuild clean
rm -rf .symlinks/
rm -rf Pods
rm -rf Podfile.lock
cd ..