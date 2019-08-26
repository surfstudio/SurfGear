#!/usr/bin/env bash
flutter clean
cd ios/
pod cache clean --all
#rm -rf ~/Library/Developer/Xcode/DerivedData todo uncomment
xcodebuild clean
rm -rf .symlinks/
rm -rf Pods
rm -rf Podfile.lock
cd ..