#!/usr/bin/env bash
flutter upgrade; flutter clean;
flutter build ios --release -t lib/main-qa.dart
# проверить
mv build/ios/iphoneos/Runner.app build/ios/iphoneos/Runner-qa.app

flutter clean;
flutter build ios --release -t lib/main-release.dart
mv build/ios/iphoneos/Runner.app build/ios/iphoneos/Runner-release.app
