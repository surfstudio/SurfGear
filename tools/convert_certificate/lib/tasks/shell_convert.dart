import 'dart:io';

import 'package:shell/shell.dart';

/// todo: форматов сертификатов больше, чем 2
Future<File> convert(String inputPath, String outputPath, String name) async {
  final shell = Shell();
  final res = name.split('.')[0];

  /// split obligatory, otherwise it will not work and will not give out errors
  final commandShell = _commandOpenssl(inputPath, outputPath, res).split(' ');

  final processResult = await shell.run('openssl', [...commandShell]);

  if (processResult.exitCode != 0) {
    print(processResult.stderr);

    return Future.error(Exception('Certificate conversion error'));
  }
  print(processResult.stdout);

  return File('$outputPath\/$res.pem');
}

String _commandOpenssl(String inputPath, String outputPath, String name) {
  return 'x509 -inform der -in $inputPath -out $outputPath/${name}.pem';
}
