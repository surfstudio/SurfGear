import 'dart:io';

import 'package:path/path.dart' as path;

/// Создаем файл dart с сертификатом
Future<void> certificateBinarization(File file) async {
  final fileNameWithoutExt = path.basenameWithoutExtension(file.path);
  final cert = file.readAsBytesSync();
  final res = 'const List<int> $fileNameWithoutExt = <int>[${_join(cert)}];';

  final resFile = File('${file.parent.path}' '/$fileNameWithoutExt.dart');
  await resFile.writeAsString(res);
}

String _join(List<int> list) {
  return list.join(', ');
}
