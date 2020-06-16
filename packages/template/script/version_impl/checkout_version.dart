import 'dart:convert';
import 'dart:io';
import 'package:pedantic/pedantic.dart';

import 'package:args/args.dart';

void main(List<String> arguments) async {
  exitCode = 0;
  final parser = ArgParser();

  var args = parser.parse(arguments).arguments;
  if (args.isEmpty) {
    exitCode = 1;
    throw Exception("You should pass version of flutter to argument.");
  } else {
    var version = args[0];

    var checkVersion = await Process.run('flutter', ['--version', '--machine']);

    var needChangeVersion = true;

    // если запрос завершился ошибкой тогда все равно попробуем сменить версию
    if (checkVersion.stderr.toString().isEmpty) {
      var parsedOut = json.decode(checkVersion.stdout);
      var currentVersion = parsedOut["frameworkVersion"];

      if (currentVersion != null && currentVersion[0] != "v") {
        currentVersion = "v$currentVersion";
      }

      needChangeVersion = currentVersion != version;
    }

    if (needChangeVersion) {
      unawaited(Process.run('flutter', ['version', version]).then((result) {
        stdout.write(result.stdout);
        stderr.write(result.stderr);
      }));
    } else {
      print('Current version is equal to target version. Skipping checkout...');
    }
  }
}
