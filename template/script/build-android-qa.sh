#!/usr/bin/env bash
cd ..
flutter upgrade; flutter clean; flutter build apk --release -t lib/main-qa.dart --target-platform android-arm64;
cd ./build/app/outputs/apk/release/

mv app-release.apk app-qa-x64.apk

ls -la
cd ../../../../..;
ls -la

flutter build apk --release -t lib/main-qa.dart;
cd ./build/app/outputs/apk/release/

mv app-release.apk app-qa.apk
