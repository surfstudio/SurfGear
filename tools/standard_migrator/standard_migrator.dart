import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart';

const String _pathCommandName = 'path';
const String _pathCommandAbr = 'p';

const List<String> _elementList = <String>[
  'analytics',
  'auto_reload',
  'background_worker',
  'bottom_navigation_bar',
  'bottom_sheet',
  'build_context_holder',
  'datalist',
  'event_filter',
  'geolocation',
  'injector',
  'logger',
  'mixed_list',
  'mwwm',
  'network',
  'network_cache',
  'permission',
  'push',
  'storage',
  'surf_util',
  'swipe_refresh',
  'tabnavigator',
  'template',
];

const String _pubspecName = 'pubspec.yaml';

/// Script for migration project to new scheme of flutter-standard.
/// You can set "path" parameter to select directory, else current dir
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
  var path = args[_pathCommandName] ?? Directory.current.path;

  var pubspecFile = File(join(path, _pubspecName));

  if (!pubspecFile.existsSync()) {
    exitCode = 1;

    throw Exception("Pubspec file not found.");
  }

  var pubspec = pubspecFile.readAsStringSync();

  for (var element in _elementList) {
    pubspec.replaceAll('path: $element', 'path: packages/$element');
  }

  pubspecFile.writeAsStringSync(pubspec);
}
