import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart';

const String _pathCommandName = 'path';
const String _pathCommandAbr = 'p';

const String _packagesDirPath = '../../packages';

const String _pubspecName = 'pubspec.yaml';

/// Script for migration project to new scheme of flutter-standard.
/// You must set "path" parameter with path to project
/// For example: dart standard_migrator.dart -p path/to/any/project
///
/// Exit codes:
/// 0 - success
/// 1 - error
void main(List<String> arguments) {
  exitCode = 0;
  final parser = ArgParser();
  parser.addOption(_pathCommandName, abbr: _pathCommandAbr);

  var args = parser.parse(arguments);
  var path = args[_pathCommandName];

  if (path == null) {
    throw Exception("Expected path to project.");
  }

  var pubspecFile = File(join(path, _pubspecName));

  if (!pubspecFile.existsSync()) {
    exitCode = 1;

    throw Exception("Pubspec file not found.");
  }

  var pubspec = pubspecFile.readAsStringSync();

  var packagesDir = Directory(_packagesDirPath);

  if (!packagesDir.existsSync()) {
    exitCode = 1;

    throw Exception("Packages directory not found.");
  }

  var elementList = packagesDir.listSync().where((e) => FileSystemEntity.isDirectorySync(e.path)).toList();

  for (var element in elementList) {
    var elementName = basename(element.path);
    pubspec = pubspec.replaceAll('path: $elementName', 'path: packages/$elementName');
  }

  pubspecFile.writeAsStringSync(pubspec);
}
