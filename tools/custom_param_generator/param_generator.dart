import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart';

const String templatePath = "template/custom_fields.template";
const String pubspecFileName = "pubspec.yaml";

const String optionAll = "all";
const String optionExclude = "exclude";

const String customParamsName = "custom:";

/// Script for generate part of pubspec file.
/// This tool will add to the pubspec file block of custom parameters.
/// Should be called with path to pubspec or "--all" flag with directory.
///
/// You also can set exclude patterns for file path if use --all.
/// Set option --exclude with values of patterns.
///
/// Exit codes:
/// 0 - success
/// 1 - error
void main(List<String> arguments) async {
  exitCode = 0;
  final parser = ArgParser();
  parser.addFlag(optionAll, negatable: false);
  parser.addMultiOption(optionExclude);

  var parsed = parser.parse(arguments);
  var args = parsed.arguments;
  var rest = parsed.rest;

  var isAll = parsed[optionAll];

  if (isAll) {
    if (rest.length != 1) {
      exitCode = 1;
      throw Exception(
          "Wrong count of arguments! You should pass path to pubspec file or --all with directory.");
    }

    var excludePatterns = parsed[optionExclude];

    await _handleAllIn(rest[0], excludePatterns);
  } else {
    if (args.length != 1) {
      exitCode = 1;
      throw Exception(
          "Wrong count of arguments! You should pass path to pubspec file or --all with directory.");
    }

    await _handleFile(args[0]);
  }
}

/// Add to all files custom template in this directory and subdirectories,
/// exclude matched by excluded patterns list.
Future<void> _handleAllIn(String dirPath, List<String> excluded) async {
  var directory = Directory(dirPath);

  var files = await directory
      .list(recursive: true)
      .where((file) =>
          file.path.contains(pubspecFileName) &&
          !_checkExclude(file.path, excluded))
      .toList();

  for (var file in files) {
    _handleFile(file.path);
  }
}

bool _checkExclude(String dirPath, List<String> excluded) {
  for (var pattern in excluded) {
    if (dirPath.contains(pattern)) {
      return true;
    }
  }

  return false;
}

/// Add to file custom template
Future<void> _handleFile(String filePath) async {
  if (!filePath.contains(pubspecFileName)) {
    exitCode = 1;
    throw Exception("File should be pubspec.yaml.");
  }

  var alreadyHasParams = await _checkParams(filePath);
  if (!alreadyHasParams) {
    _modifyFile(filePath);
  }

  print("File $filePath was updated.");
}

Future<bool> _checkParams(String filePath) async {
  var file = File(filePath);

  var isExist = await file.exists();
  if (!isExist) {
    exitCode = 1;
    throw Exception("Pubspec file by pass $filePath not found.");
  }

  var fileContent = await file.readAsString();
  return fileContent.contains(customParamsName);
}

Future<void> _modifyFile(String filePath) async {
  var file = File(filePath);

  var templateFile = File(templatePath);

  var isExist = await templateFile.exists();
  if (!isExist) {
    exitCode = 1;
    throw Exception("Pubspec template file not found.");
  }

  var fileDir = file.parent;

  var moduleName = basename(fileDir.path);

  var template = await templateFile.readAsString();
  template = template.replaceAll("\$pathToModule", moduleName);

  var fileSink = await file.openWrite(mode: FileMode.append);
  fileSink.writeln();
  fileSink.writeln(template);

  await fileSink.close();
}
