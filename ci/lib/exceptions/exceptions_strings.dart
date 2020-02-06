const String licenseSampleNotFoundExceptionText = 'Образец лицензии не найден. Проверьте наличие файла лиценизии и конфигурацию приложения.';
const String copyrightSampleNotFoundExceptionText = 'Образец копирайта не найден. Проверьте наличие файла копирайта и конфигурацию приложения.';

String getGitAddExceptionText(String filepath) => 'Не возможно выполнить git add $filepath';
String getGitCommitExceptionText(String filepath) => 'Не возможно выполнить git commit $filepath';
String getGitPushExceptionText(String filepath) => 'Не возможно выполнить git push $filepath';
String getCommitHashExceptionText(String error) => 'Не удалось получить commit hash:\n$error';

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

String getCheckoutExceptionText(String error) => 'Не удалось переключиться в нужное состояние:\n$error';
String getStabilityDevChangedExceptionText(String module) => 'Модуль $module стал стабильным в dev ветке';

String getOpenSourceModuleCanNotBePublishExceptionText(String module) => 'OpenSource модуль: $module не может быть опубликован';
String getTestsFailedExceptionText(int modulesCount, String error) => 'Тесты провалились в следующих $modulesCount модулях:\n\n$error';