import 'package:convert_certificate/services/parser/command_parser.dart';
import 'package:convert_certificate/tasks/analysis_certificate.dart';
import 'package:convert_certificate/tasks/certificate_binaryization.dart';
import 'package:convert_certificate/tasks/check_file.dart';
import 'package:convert_certificate/tasks/shell_convert.dart';

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
      final res = await analysisCertificate(file);

      if (res) {
        await certificateBinarization(file);
      } else {
        final fileConvert = await shellConvert(
          file.path,
          pathCertificate.inputPath,
          pathCertificate.name,
        );
        await certificateBinarization(fileConvert);
      }
    } catch (e) {
      rethrow;
    }
  }
}
