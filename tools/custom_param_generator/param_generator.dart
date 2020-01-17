import 'dart:io';

import 'package:args/args.dart';

const String templatePath = "template/pubspec.template";

/// Script for generate part of pubspec file.
/// This tool will add to the pubspec file block of custom parameters.
/// Should be called with path to pubspec or "all" flag with directory.
///
/// Exit codes:
/// 0 - success
/// 1 - error
void main(List<String> arguments) async {
  exitCode = 0;
  final parser = ArgParser();
  parser.addFlag("all", negatable: false);

  var parsed = parser.parse(arguments);
  var args = parsed.arguments;
  var rest = parsed.rest;

  var isAll = parsed["all"];

  if (isAll) {
    if (rest.length != 1) {
      exitCode = 1;
      throw Exception(
          "Wrong count of arguments! You should pass path to pubspec file or --all with directory.");
    }

    await _handleAllIn(rest[0]);
  } else {
    if (args.length != 1) {
      exitCode = 1;
      throw Exception(
          "Wrong count of arguments! You should pass path to pubspec file or --all with directory.");
    }

    await _handleFile(args[0]);
  }
}

Future _handleAllIn(String dirPath) async {
  var directory = Directory(dirPath);

  var files = await directory
      .list(recursive: true)
      .where((file) => file.path.contains("pubspec.yaml"))
      .toList();

  print(dirPath);

  for (var file in files) {
    _handleFile(file.path);
  }
}

Future _handleFile(String filePath) async {
  if (!filePath.contains("pubspec.yaml")) {
    exitCode = 1;
    throw Exception("File should be pubspec.yaml.");
  }

  if (!(await _checkParams(filePath))) {
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
  return fileContent.contains("custom:");
}

Future _modifyFile(String filePath) async {
  var file = File(filePath);

  var templateFile = File(templatePath);

  var isExist = await templateFile.exists();
  if (!isExist) {
    exitCode = 1;
    throw Exception("Pubspec template file not found.");
  }

  var template = await templateFile.readAsString();

  var fileSink = await file.openWrite(mode: FileMode.append);
  fileSink.writeln();
  fileSink.writeln(template);

  await fileSink.close();
}
