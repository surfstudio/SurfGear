import 'dart:io';

import 'package:path/path.dart' as path;

/// We create a dart file with a certificate.
Future<void> preparationCode(File file) async {
  final fileNameWithoutExt = path.basenameWithoutExtension(file.path);
  final cert = file.readAsBytesSync();
  final content = 'const List<int> $fileNameWithoutExt = <int>[${_join(cert)}];';

  await _saveFile(file, fileNameWithoutExt, content);
}

String _join(List<int> list) => list.join(', ');

/// save certificate
Future<void> _saveFile(File file, String fileNameWithoutExt, String content) async {
  final resFile = File('${file.parent.path}' '/$fileNameWithoutExt.dart');
  await resFile.writeAsString(content);
}
