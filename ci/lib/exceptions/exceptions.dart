import 'exceptions_strings.dart';

/// Базовая ошибка модуля ci
abstract class BaseCiException implements Exception {
  final String message;

  BaseCiException(this.message);
}

/// Общие ошибки

/// Не найден файл лицензии для модуля.
class FileNotFoundException extends BaseCiException {
  FileNotFoundException(String message) : super(message);
}

/// Базовая ошибка выполнения команд Git
abstract class GitProcessException extends BaseCiException {
  GitProcessException(String message) : super(message);
}

/// Ошибки функционала

/// Не найдены модули. Например, пользователь указал неправильный путь.
class ModulesNotFoundException implements Exception {
  final String message;

  ModulesNotFoundException(this.message);
}

/// Модуль, помеченный как stable, был изменён.
class StableModulesWasModifiedException implements Exception {
  final String message;

  StableModulesWasModifiedException(this.message);
}

/// Ошибка при сборке модуля.
///
/// Выбрасывается как в случае сборки единичного модуля так и списка модулей.
class PackageBuildException extends BaseCiException {
  PackageBuildException(String message) : super(message);
}

/// Не найден образец лицензии.
class LicenseSampleNotFoundException extends FileNotFoundException {
  LicenseSampleNotFoundException({
    String message = licenseSampleNotFoundExceptionText,
  }) : super(message);
}

/// Не найден образец копирайта.
class CopyrightSampleNotFoundException extends FileNotFoundException {
  CopyrightSampleNotFoundException({
    String message = copyrightSampleNotFoundExceptionText,
  }) : super(message);
}

/// Не найден файл лицензии для модуля.
class LicenseFileNotFoundException extends BaseCiException {
  LicenseFileNotFoundException(String message) : super(message);
}

/// Ошибка - лицензия модуля устарела.
class LicenseFileObsoleteException extends BaseCiException {
  LicenseFileObsoleteException(String message) : super(message);
}

/// Ошибка - копирайт файла отсутствует.
class FileCopyrightMissedException extends BaseCiException {
  FileCopyrightMissedException(String message) : super(message);
}

/// Ошибка - копирайт файла устарел.
class FileCopyrightObsoleteException extends BaseCiException {
  FileCopyrightObsoleteException(String message) : super(message);
}

/// Ошибка лицензирования модуля.
/// 
/// Выбрасывается как в случае проверки единичного модуля так и списка модулей.
class PackageLicensingException extends BaseCiException {
  PackageLicensingException(String message) : super(message);
}

/// Ошибка при добавлении лицензии.
class AddLicenseFailException extends BaseCiException {
  AddLicenseFailException(String message) : super(message);
}

/// Ошибка при добавлении копирайта.
class AddCopyrightFailException extends BaseCiException {
  AddCopyrightFailException(String message) : super(message);
}

/// Модуль не прошёл проверку статического анализатора
/// `flutter analyze`
class AnalyzerFailedException implements Exception {
  final String message;

  AnalyzerFailedException(this.message);
}


/// Не можем опубликовать модуль OpenSource
class ModuleNotPublishOpenSourceException implements Exception {
  final String message;

  /// Вызывается [PubDryRunTask]
  ModuleNotPublishOpenSourceException(this.message);
}

/// Нет описание версии в CHANGELOG.md
class ModuleNotReadyReleaseVersion implements Exception {
  final String message;

  /// Вызывается [PubCheckReleaseVersionTask]
  ModuleNotReadyReleaseVersion(this.message);
}

/// Ошибка получения hash комита.
class CommitHashException extends GitProcessException {
  CommitHashException(String message) : super(message);
}

/// Ошибка выполнения checkout.
class CheckoutException extends GitProcessException {
  CheckoutException(String message) : super(message);
}

/// Модуль поменял значение стабильности в dev ветке.
class StabilityDevChangedException extends BaseCiException {
  StabilityDevChangedException(String message) : super(message);
}

/// Ошибка парсинга команды
class ParseCommandException extends BaseCiException {
  ParseCommandException(String message) : super(message);
}