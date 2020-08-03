import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';

Future<void> main(List<String> arguments) async {
  exitCode = 0;
  final parser = ArgParser();

  final List<String> args = parser.parse(arguments).arguments;
  if (args.isEmpty) {
    exitCode = 1;
    throw Exception('You should pass version of flutter to argument.');
  } else {
    final String version = args[0];

    final ProcessResult checkVersion = await Process.run(
      'flutter',
      ['--version', '--machine'],
    );

    var needChangeVersion = true;

    // если запрос завершился ошибкой тогда все равно попробуем сменить версию
    if (checkVersion.stderr.toString().isEmpty) {
      final parsedOut = json.decode(
        checkVersion.stdout as String,
      ) as Map<String, String>;
      String currentVersion = parsedOut['frameworkVersion'];

      if (currentVersion != null && currentVersion[0] != 'v') {
        currentVersion = 'v$currentVersion';
      }

      needChangeVersion = currentVersion != version;
    }

    if (needChangeVersion) {
      // ignore: unawaited_futures
      Process.run('flutter', ['version', version]).then((result) {
        stdout.write(result.stdout);
        stderr.write(result.stderr);
      });
    } else {
      // ignore: avoid_print
      print('Current version is equal to target version. Skipping checkout...');
    }
  }
}
