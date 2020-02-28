import 'dart:io';

import 'package:args/args.dart';

const String templatePath = "template/";

final beforeCapitalLetter = RegExp(r"(?=[A-Z])");

String widgetName;
String snakeWidgetName;
String dirPath;

/// Script for generation mwwm template files.
/// Need parameters: name of widget, path to create widget environment files,
/// passed in this order.
/// For example: dart mwwmgen.dart TestScreen ../../lib/ui/screen/test
/// That should create in lib/ui/screen/test directory form the root of the
/// project an environment for widget with name TestScreen.
/// Prepared template for generation should be in template directory same
/// level with script.
///
/// Exit codes:
/// 0 - success
/// 1 - error
void main(List<String> arguments) {
  exitCode = 0;
  final parser = ArgParser();

  var args = parser.parse(arguments).arguments;

  if (args.length != 2) {
    exitCode = 1;
    throw Exception(
        "Wrong count of arguments! You should path name of widget and directory, in order [-name -dir].");
  } else {
    widgetName = args[0];
    snakeWidgetName = _toSnake(widgetName);

    dirPath = args[1];

    var lastDirSymbol = dirPath[dirPath.length - 1];
    if (lastDirSymbol != "/" || lastDirSymbol != "\\") {
      dirPath += Platform.pathSeparator;
    }

    _generate();
  }
}

String _toSnake(String name) {
  var parts = widgetName.split(beforeCapitalLetter);
  return parts.map((word) => word.toLowerCase()).join("_");
}

void _generate() async {
  var templateDir = Directory(templatePath);

  var isExist = await templateDir.exists();
  if (!isExist) {
    exitCode = 1;
    throw Exception("Project should contain templates for generation.");
  }

  await _createDirIfNotExist(dirPath);

  var templatesList =
      await templateDir.listSync(recursive: true, followLinks: false).toList();

  var templatesDirs = templatesList.where((FileSystemEntity entity) {
    var isDir = FileSystemEntity.isDirectorySync(entity.path);
    return isDir;
  });

  var templatesFiles = templatesList.where((FileSystemEntity entity) {
    var isFile = FileSystemEntity.isFileSync(entity.path);
    return isFile;
  });

  // copy structure in target path
  await _copyStructure(templatesDirs, dirPath);

  List<File> newFiles = [];
  Map<String, String> renamed = {};

  await _copyFiles(templatesFiles, dirPath, newFiles, renamed);
  await _updateImports(newFiles, renamed);
}

Future _copyStructure(Iterable<FileSystemEntity> list, String target) async {
  for (var dir in list) {
    var relative = _getRelativePath(dir.path, templatePath);
    await _createDirIfNotExist(target + relative);
  }
  ;
}

Future _copyFiles(Iterable<FileSystemEntity> list, String target,
    List<File> newFiles, Map<String, String> renamed) async {
  for (var fileEntity in list) {
    var relative = _getRelativePath(fileEntity.path, templatePath);
    var file = File(fileEntity.path);
    var newFilePath = target + relative;
    File newFile;
    try {
      newFile = await file.copy(newFilePath);
    } catch (e) {
      print("Failed to create file $newFilePath, reason: $e");
    }

    var fileContent = await newFile.readAsString();
    fileContent = fileContent.replaceAll("\$Temp\$", widgetName);
    await newFile.writeAsString(fileContent);
    var dirName = newFile.parent.path + Platform.pathSeparator;
    var fileName = newFile.path.replaceFirst(dirName, "");
    var newFileName = fileName.replaceFirst("temp", snakeWidgetName);
    newFile = await newFile.rename(dirName + newFileName);

    newFiles.add(newFile);
    renamed[fileName] = newFileName;
  }
}

Future _updateImports(List<File> newFiles, Map<String, String> renamed) async {
  for (var file in newFiles) {
    var content = await file.readAsStringSync();
    renamed.forEach((key, value) {
      content = content.replaceAll(key, value);
    });

    await file.writeAsString(content);
  }
}

Future<Directory> _createDirIfNotExist(String dirPath) async {
  var dir = Directory(dirPath);

  var isExist = await dir.exists();
  if (!isExist) {
    await dir.create(recursive: true);
  }

  return dir;
}

String _getRelativePath(String path, String parentPath) {
  if (path.startsWith(parentPath)) {
    return path.replaceFirst(parentPath, "");
  } else {
    return "";
  }
}
