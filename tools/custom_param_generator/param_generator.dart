import 'dart:io';

import 'package:args/args.dart';

const String templatePath = "template/pubspec.template";

String pubspecFilePath;

/// Script for generate part of pubspec file.
/// This tool will add to the pubspec file block of custom parameters.
/// Should be called with path to pubspec.
///
/// Exit codes:
/// 0 - success
/// 1 - error
void main(List<String> arguments) async {
  exitCode = 0;
  final parser = ArgParser();

  var args = parser.parse(arguments).arguments;

  if (args.length != 1) {
    exitCode = 1;
    throw Exception(
        "Wrong count of arguments! You should pass path to pubspec file.");
  } else {
    pubspecFilePath = args[0];

    if (!(await _checkParams(pubspecFilePath))) {
      _modifyFile(pubspecFilePath);
    }

    print("File $pubspecFilePath was updated.");
  }
}

Future<bool> _checkParams(var filePath) async{
  var file = File(filePath);

  var isExist = await file.exists();
  if (!isExist) {
    exitCode = 1;
    throw Exception("Pubspec file by pass $pubspecFilePath not found.");
  }

  var fileContent = await file.readAsString();
  return fileContent.contains("custom:");
}

Future _modifyFile(var filePath) async{
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