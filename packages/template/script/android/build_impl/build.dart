import 'dart:io';

import 'package:args/args.dart';

const String releaseBuildType = 'release';
const String platform64 = 'android-arm64';
const String apkPrefix64="arm64-v8a";
const String apkPrefixV7 = "armeabi-v7a";
const String apkPrefixUniversal = "universal";

String flavor = "dev";
String apk_path;
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

  var args = parser
      .parse(arguments)
      .arguments;
  if (args.length != 1) {
    exitCode = 1;
    throw Exception("You should pass build type.");
  } else {
    buildType = args[0];

    build();
  }
}

void build() async {
  resolveFlavor();
  await buildApk();
  rename();
}

void resolveFlavor() {
  if (buildType == releaseBuildType) {
    flavor = "prod";
  }

  apk_path = "./build/app/outputs/apk/${flavor}/release/";
}

void buildApk() async {
  print("Build type ${buildType}");

  var result = await Process.run('flutter', ['build', "apk", "-t", "lib/main-${buildType}.dart", "--flavor", "${flavor}", "--split-per-abi"]);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
}

void rename() async {
  var postfix = "${buildType}";
  print("Postfix ${postfix}");
  print("Make postfix ...");

  var currentName = "app-${flavor}-${apkPrefixV7}-release.apk";
  var newName = "app-${postfix}-${apkPrefixV7}.apk";
  await renameApk(currentName, newName);

  currentName = "app-${flavor}-${apkPrefix64}-release.apk";
  newName = "app-${postfix}-${apkPrefix64}.apk";
  await renameApk(currentName, newName);
}

void renameApk(String currentName, String newName) async {
  var apk = File(apk_path + currentName);
  await apk.rename(apk_path + newName);

  print("$currentName renamed to $newName");
}