#!/usr/bin/env bash
flutter upgrade; flutter clean;  flutter build apk --release -t lib/main-qa.dart;
cd ./build/app/outputs/apk/release/

mv app-release.apk app-qa.apk

ls -la
cd ../../../../..;
ls -la

flutter build apk --release -t lib/main-release.dart;