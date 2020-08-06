// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:io';

import 'package:args/args.dart';

const String releaseBuildType = 'release';
const String platform64 = 'android-arm64';
const String apkPrefix64 = 'arm64-v8a';
const String apkPrefixV7 = 'armani-v7a';
const String apkPrefixUniversal = 'universal';

String flavor = 'dev';
String apkPath;
String buildType;

/// Script for build apk.
/// Need parameter: build type -release or -qa.
/// See also usage.
///
/// Exit codes:
/// 0 - success
/// 1 - error
void main(List<String> arguments) {
  exitCode = 0;
  final parser = ArgParser();

  final args = parser.parse(arguments).arguments;
  if (args.length != 1) {
    exitCode = 1;
    throw Exception('You should pass build type.');
  } else {
    buildType = args[0];

    build();
  }
}

Future<void> build() async {
  resolveFlavor();
  await buildApk();
  // ignore: unawaited_futures
  rename();
}

void resolveFlavor() {
  if (buildType == releaseBuildType) {
    flavor = 'prod';
  }

  apkPath = './build/app/outputs/apk/$flavor/release/';
}

Future<void> buildApk() async {
  // ignore: avoid_print
  print('Build type $buildType');

  final result = await Process.run(
    'flutter',
    [
      'build',
      'apk',
      '-t',
      'lib/main-$buildType.dart',
      '--flavor',
      flavor,
      '--split-per-abi'
    ],
  );
  stdout.write(result.stdout);
  stderr.write(result.stderr);
}

Future<void> rename() async {
  final postfix = buildType;
  // ignore: avoid_print
  print('Postfix $postfix');
  // ignore: avoid_print
  print('Make postfix ...');

  var currentName = 'app-$flavor-$apkPrefixV7-release.apk';
  var newName = 'app-$postfix-$apkPrefixV7.apk';
  await renameApk(currentName, newName);

  currentName = 'app-$flavor-$apkPrefix64-release.apk';
  newName = 'app-$postfix-$apkPrefix64.apk';
  await renameApk(currentName, newName);
}

Future<void> renameApk(String currentName, String newName) async {
  final apk = File(apkPath + currentName);
  await apk.rename(apkPath + newName);

  // ignore: avoid_print
  print('$currentName renamed to $newName');
}
