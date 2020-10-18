import 'dart:io';

/// Ищем в файле сертификата
const _textContent = 'BEGIN CERTIFICATE';

/// Является сертификат PEM
///
/// todo: тут стоит рассмотреть подход к проверки, расширений больше
/// todo: https://rtfm.co.ua/tlsssl-der-vs-pem-tipy-fajlov-i-ix-konvertaciya/
Future<bool> analysisCertificate(File file) async {
  String content;
  try {
    content = await file.readAsString();
  } on FileSystemException {
    /// при попытке прочитать бинарный, вылетит ошибка
    return false;
  }

  return content.contains(_textContent) ? true : false;
}
