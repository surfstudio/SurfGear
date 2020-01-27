const String licenseSampleNotFoundExceptionText = 'Образец лицензии не найден. Проверьте наличие файла лиценизии и конфигурацию приложения.';
const String copyrightSampleNotFoundExceptionText = 'Образец копирайта не найден. Проверьте наличие файла копирайта и конфигурацию приложения.';

String getPackageLicensingExceptionText(String error) => 'Обнаружены проблемы с лицензиями:\n $error';
String getPackageBuildExceptionText(String error) => 'Не удалось собрать следующие модули: $error';
String getAddLicenseFailExceptionText(String error) => 'Не удалось добавить лицензии в модули: $error';
String getAddCopyrightFailExceptionText(String error) => 'Не удалось добавить копирайты в файлы:\n $error';