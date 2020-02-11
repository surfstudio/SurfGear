/// Common
String getFileNotFoundExceptionText(String filepath) => 'File $filepath not found';
String getElementNotFoundExceptionText(String moduleName) => 'Модуль $moduleName не найден';
String getFormatExceptionText(String error) => 'Неправильный формат!\n$error';


/// Licensing
const String licenseSampleNotFoundExceptionText = 'Образец лицензии не найден. Проверьте наличие файла лиценизии и конфигурацию приложения.';
const String copyrightSampleNotFoundExceptionText = 'Образец копирайта не найден. Проверьте наличие файла копирайта и конфигурацию приложения.';
String getLicenseFileNotFoundExceptionText(String licensePath) => 'Файл лицензии $licensePath не найден';
String getLicenseFileObsoleteExceptionText(String licensePath) => 'Файл лицензии $licensePath устарел';
String getPackageLicensingExceptionText(String error) => 'Обнаружены проблемы с лицензиями:\n $error';
String getPackageLicensingExceptionModuleText(String package, String error) => 'Модуль $package имеет проблемы с лицензированием:\n$error';
String getAddLicenseFailExceptionText(String error) => 'Не удалось добавить лицензии в модули: $error';
String getCopyrightFileNotFoundExceptionText(String filepath) => 'Копирайт файла $filepath не найден';
String getCopyrightFileObsoleteExceptionText(String filepath) => 'Копирайт файла $filepath устарел';
String getAddCopyrightFailExceptionText(String error) => 'Не удалось добавить копирайты в файлы:\n $error';

/// Build
String getPackageBuildExceptionText(String error) => 'Не удалось собрать следующие модули: $error';
String getStabilityDevChangedExceptionText(String module) => 'Модуль $module стал стабильным в dev ветке';

/// Git
const String gitDescribeExceptionText = 'Ну удалось получить описание текущей ветки';
String getCommitHashExceptionText(String error) => 'Не удалось получить commit hash:\n$error';
String getCheckoutExceptionText(String error) => 'Не удалось переключиться в нужное состояние:\n$error';
String getGitAddExceptionText(String filepath) => 'Не возможно выполнить git add $filepath';
String getGitCommitExceptionText(String filepath) => 'Не возможно выполнить git commit $filepath';
String getGitPushExceptionText(String filepath) => 'Не возможно выполнить git push $filepath';

/// Tests
String getTestsFailedExceptionText(int modulesCount, String error) => 'Тесты провалились в следующих $modulesCount модулях:\n\n$error';

/// Command
String getParseCommandExceptionText(String command) => 'Не удалось распарсить команду $command';
String getCommandHandlerNotFoundExceptionText(String command) => 'Не найден обработчик для команды $command';
String getCommandFormatExceptionText(String cmd, String error) => 'Неправильная конфигурация команды $cmd : $error';

/// Publish
String getPubCheckReleaseVersionExceptionText(String module) => '$module: модуль, с непрописанной версией Release Notes';
String getContainsCyrillicInChangelogExceptionText(String package, String name) => 'Библиоткека $name содержит киррилицу в $package/CHANGELOG.md';
String getOpenSourceModuleCanNotBePublishExceptionText(String module) => 'OpenSource модуль: $module не может быть опубликован';