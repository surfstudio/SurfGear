import 'package:convert_certificate/convert_certificate.dart';

/// Util for representation of certificate as variable list of bytes;
///
/// Should set certificate name from certs folder.
///
/// Exit codes:
/// 0 - success
/// 1 - error
void main(List<String> arguments) async {
  final convertCertificate = ConvertCertificate();
  await convertCertificate.execute(arguments);
}
