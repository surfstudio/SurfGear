#!/usr/bin/env bash
flutter build apk --release -t lib/main-release.dart --target-platform android-arm64;
cd ./build/app/outputs/apk/release/

mv app-release.apk app-release-x64.apk

ls -la
cd ..; cd ..; cd ..; cd ..; cd ..;
ls -la

flutter build apk --release -t lib/main-release.dart;