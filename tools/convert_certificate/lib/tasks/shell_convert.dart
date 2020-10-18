import 'dart:io';

import 'package:shell/shell.dart';

/// todo: форматов сертификатов больше, чем 2
Future<File> shellConvert(String inputPath, String outputPath, String name) async {
  final res = name.split('.')[0];

  final shell = Shell();

  /// split обязателен, иначе работать не будет и ошибок не выдаст
  final commandShell = 'x509 -inform der -in $inputPath -out $outputPath/${res}.pem'.split(' ');

  final processResult = await shell.run('openssl', [...commandShell]);

  if (processResult.exitCode != 0) {
    print(processResult.stderr);

    return Future.error(Exception('Certificate conversion error'));
  }
  print(processResult.stdout);

  return File('$outputPath\/$res.pem');
}
