#!/usr/bin/env bash
cd ..
flutter upgrade; flutter clean;
flutter build ios --release -t lib/main-release.dart --no-codesign