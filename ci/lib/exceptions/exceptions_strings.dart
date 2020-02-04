const String licenseSampleNotFoundExceptionText = 'Образец лицензии не найден. Проверьте наличие файла лиценизии и конфигурацию приложения.';
const String copyrightSampleNotFoundExceptionText = 'Образец копирайта не найден. Проверьте наличие файла копирайта и конфигурацию приложения.';

String getFileNotFoundExceptionText(String filepath) => 'File $filepath not found';
String getLicenseFileNotFoundExceptionText(String licensePath) => 'Файл лицензии $licensePath не найден';
String getLicenseFileObsoleteExceptionText(String licensePath) => 'Файл лицензии $licensePath устарел';
String getPackageLicensingExceptionText(String error) => 'Обнаружены проблемы с лицензиями:\n $error';
String getPackageLicensingExceptionModuleText(String package, String error) => 'Модуль $package имеет проблемы с лицензированием:\n$error';
String getPackageBuildExceptionText(String error) => 'Не удалось собрать следующие модули: $error';
String getAddLicenseFailExceptionText(String error) => 'Не удалось добавить лицензии в модули: $error';
String getCopyrightFileNotFoundExceptionText(String filepath) => 'Копирайт файла $filepath не найден';
String getCopyrightFileObsoleteExceptionText(String filepath) => 'Копирайт файла $filepath устарел';
String getAddCopyrightFailExceptionText(String error) => 'Не удалось добавить копирайты в файлы:\n $error';

String getCommitHashExceptionText(String error) => 'Не удалось получить commit hash:\n$error';
String getCheckoutExceptionText(String error) => 'Не удалось переключиться в нужное состояние:\n$error';

String getStabilityDevChangedExceptionText(String module) => 'Модуль $module стал стабильным в dev ветке';

String getParseCommandExceptionText(String command) => 'Не удалось распарсить команду $command';
String getCommandHandlerNotFoundExceptionText(String command) => 'Не найден обработчик для команды $command';
String getCommandFormatExceptionText(String cmd, String error) => 'Неправильная конфигурация команды $cmd : $error';

String getElementNotFoundExceptionText(String moduleName) => 'Модуль $moduleName не найден';