import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart';

const String _pathCommandName = 'path';
const String _pathCommandAbr = 'p';

const String _pubspecName = 'pubspec.yaml';

/// Script for migration project to new mwwm (surf-mwwm).
/// You must set "path" parameter with path to project that will be migrated.
/// For example: dart mwwm_migrator.dart -p path/to/any/project
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
  pubspec = pubspec.replaceAll('path: mwwm', 'path: packages/surf_mwwm');
  pubspec = pubspec.replaceAll('mwwm:', 'surf_mwwm:');

  pubspecFile.writeAsStringSync(pubspec);

  var packageDir = Directory(path);

  var dartFiles = packageDir
      .listSync(recursive: true)
      .where((fe) => fe.path.contains(".dart"))
      .toList();

  for (var files in dartFiles) {
    fixExport(files);
  }
}

void fixExport(FileSystemEntity fileEntity) {
  var file = File(fileEntity.path);

  /// файл точно существует потому что мы его получали из файловой системы
  var content = file.readAsStringSync();

  content = content.replaceAll("import 'package:mwwm", "import 'package:surf_mwwm");

  file.writeAsStringSync(content);
}