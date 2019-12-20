import 'dart:io';

import 'package:args/args.dart';

void main(List<String> arguments) {
  exitCode = 0;
  final parser = ArgParser();

  var args = parser.parse(arguments).arguments;
  if (args.isEmpty) {
    exitCode = 1;
    Exception("You should pass version of flutter to argument.");
  } else {
    var version = args[0];

    Process.run('flutter', ['version', version]).then((result) {
      stdout.write(result.stdout);
      stderr.write(result.stderr);
    });
  }
}