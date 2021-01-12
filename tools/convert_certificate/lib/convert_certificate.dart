import 'package:certificate_binarizator/services/parser/command_parser.dart';
import 'package:certificate_binarizator/tasks/analysis_certificate.dart';
import 'package:certificate_binarizator/tasks/certificate_binaryization.dart';
import 'package:certificate_binarizator/tasks/check_file.dart';
import 'package:certificate_binarizator/tasks/shell_convert.dart';

/// Консольное приложение для создание бинарного сертификата
class CertificateConverter {
  final CommandParser commandParser = CommandParser();

  /// certificate file conversion
  Future<void> convertCertificate(List<String> arguments) async {
    try {
      final pathCertificate = await commandParser.parser(arguments);

      final file = await searchCertificate(
        pathCertificate.name,
        pathCertificate.inputPath,
      );
      final isPem = await isCertificatePemFormat(file);

      if (isPem) {
        await preparationCode(file);
      } else {
        final fileConvert = await convert(
          file.path,
          pathCertificate.inputPath,
          pathCertificate.name,
        );
        await preparationCode(fileConvert);
        fileConvert.deleteSync();
      }
    } catch (e) {
      rethrow;
    }
  }
}
