import 'package:certificate_binarizator/convert_certificate.dart';

/// Util for representation of certificate as variable list of bytes;
/// Exit codes:
/// 0 - success
/// 1 - error
void main(List<String> arguments) async {
  final convertCertificate = ConvertCertificate();
  await convertCertificate.execute(arguments);
}
