import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as path;

/// Существуте ли файл
Future<File> checkExistsFile(String name, String inputPath) async {
  final pathFile = path.join(inputPath, name);
  if (FileSystemEntity.isFileSync(pathFile)) {
    return File(pathFile);
  }
  return Future.error('File certificate $inputPath not found.');
}
