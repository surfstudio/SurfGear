import 'dart:io';

import 'package:args/args.dart';
import 'package:shell/shell.dart';

const String _projectCommandName = 'project';
const String _projectCommandAbr = 'p';

const String _standardCommandName = 'standard';
const String _standardCommandAbr = 's';

const String _pubspecName = 'pubspec.yaml';

const String _projectPrefix = 'project-';

const String _regExpLocal = r'\s(\w+)\:(\s)*path:\s\.\.\/(\1)';

String _standardPath = '../../';

String _projectName = '';

/// Script for initialization of project brunch flutter-standard.
///
/// Exit codes:
/// 0 - success
/// 1 - error
void main(List<String> arguments) async {
  exitCode = 0;

  final parser = ArgParser();
  parser.addOption(_projectCommandName, abbr: _projectCommandAbr);
  parser.addOption(_standardCommandName, abbr: _standardCommandAbr);

  var args = parser.parse(arguments);
  _projectName = args[_projectCommandName];
  var parsedStandardPath = args[_standardCommandName];
  if (parsedStandardPath != null) {
    _standardPath = parsedStandardPath;
  }

  if (_projectName == null) {
    exitCode = 1;

    throw Exception("Expected name of project.");
  }

  var sh = Shell(workingDirectory: _standardPath);
  var packageDir = Directory(_standardPath).listSync().firstWhere(
        (fe) => fe.path.endsWith('packages'),
        orElse: () => null,
      );

  if (packageDir == null) {
    exitCode = 1;

    throw Exception(
        "Wrong directory of standard or wrong structure - packages not found.");
  }

  /// Create new branch for project variant of standard and switch to there.
  var branchName = _projectPrefix + _projectName;
  var tagName = branchName + '-0';
  _printRes(
    await sh.run(
      'git',
      [
        'checkout',
        '-b',
        branchName,
      ],
    ),
  );

  /// Change pubspecs - we need git dependencies instead local.

  var packageList = Directory(packageDir.path)
      .listSync()
      .where((fe) => FileSystemEntity.isDirectorySync(fe.path))
      .toList();

  for (var package in packageList) {
    _changeDependencies(package);
  }

  _printRes(
    await sh.run(
      'git',
      [
        'commit',
        '-am',
        'Init project $_projectName branch',
      ],
    ),
  );
  _printRes(
    await sh.run(
      'git',
      [
        'tag',
        tagName,
      ],
    ),
  );
  _printRes(
    await sh.run(
      'git',
      [
        'push',
        '-u',
        'origin',
        branchName,
      ],
    ),
  );
  _printRes(
    await sh.run(
      'git',
      [
        'push',
        'origin',
        tagName,
      ],
    ),
  );
}

void _changeDependencies(FileSystemEntity fileSystemEntity) {
  var pubspecFileEntity =
      Directory(fileSystemEntity.path).listSync().firstWhere(
            (fe) => fe.path.endsWith(_pubspecName),
            orElse: () => null,
          );

  if (pubspecFileEntity == null) {
    exitCode = 1;

    throw Exception("Pubspec in ${fileSystemEntity.path} not found.");
  }

  var pubspecFile = File(pubspecFileEntity.path);
  var pubspec = pubspecFile.readAsStringSync();
  pubspec = pubspec.replaceAllMapped(
    RegExp(_regExpLocal, multiLine: true, caseSensitive: false),
    (match) {
      var packageName = match.group(1);
      return "${packageName}:\n    git:\n     url: https://bitbucket.org/surfstudio/flutter-standard.git\n     ref: ${_projectName}-0\n     path: ${packageName}";
    },
  );

  pubspecFile.writeAsStringSync(pubspec);
}

void _printRes(ProcessResult result) {
  print(result.stdout);
  print(result.stderr);
}
