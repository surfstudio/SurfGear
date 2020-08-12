import 'dart:io';

import 'package:args/args.dart';

const String releaseBuildType = 'release';

String flavor = 'dev';
String buildType;

/// Script for build application.
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
  await buildIpa();
}

void resolveFlavor() {
  if (buildType == releaseBuildType) {
    flavor = 'prod';
  }
}

Future<void> buildIpa() async {
  // ignore: avoid_print
  print('Build type $buildType');

  final result = await Process.run('flutter', [
    'build',
    'ios',
    '-t',
    'lib/main-$buildType.dart',
    '--flavor',
    flavor,
    '--no-codesign',
    '--release'
  ]);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
}
