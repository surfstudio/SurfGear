#!/usr/bin/env bash
cd ..
flutter upgrade; flutter clean;
flutter build ios --release -t lib/main-qa.dart --no-codesign