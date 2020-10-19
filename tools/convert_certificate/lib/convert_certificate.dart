import 'dart:io';

import 'package:certificate_binarizator/services/parser/command_parser.dart';
import 'package:certificate_binarizator/tasks/analysis_certificate.dart';
import 'package:certificate_binarizator/tasks/certificate_binaryization.dart';
import 'package:certificate_binarizator/tasks/check_file.dart';
import 'package:certificate_binarizator/tasks/shell_convert.dart';

/// Консольное приложение для создание бинарного сертификата
class ConvertCertificate {
  final CommandParser commandParser = CommandParser();

  Future<void> execute(List<String> arguments) async {
    try {
      final pathCertificate = await commandParser.parser(arguments);

      final file = await checkExistsFile(
        pathCertificate.name,
        pathCertificate.inputPath,
      );
      final isPem = await analysisCertificate(file);

      if (isPem) {
        await certificateBinarization(file);
      } else {
        final fileConvert = await shellConvert(
          file.path,
          pathCertificate.inputPath,
          pathCertificate.name,
        );
        await certificateBinarization(fileConvert);
        fileConvert.deleteSync();
      }
    } catch (e) {
      rethrow;
    }
  }
}
