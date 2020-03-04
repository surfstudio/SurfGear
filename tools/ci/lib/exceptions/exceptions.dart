import 'exceptions_strings.dart';

/// Базовая ошибка модуля ci
abstract class BaseCiException implements Exception {
  final String message;

  BaseCiException(this.message);

  @override
  String toString() {
    if (message == null) return runtimeType.toString();
    return 'Exception: $message';
  }
}

/// Общие ошибки

/// Не найден модуль.
class ElementNotFoundException extends BaseCiException {
  ElementNotFoundException(String message) : super(message);
}

/// Пабспек элемента не содержит кастомных параметров.
class ElementCustomParamsMissedException extends BaseCiException {
  ElementCustomParamsMissedException(String message) : super(message);
}

// TODO: не стоит ли испльзовать ElementNotFoundException
/// Не найдены модули. Например, пользователь указал неправильный путь.
class ModulesNotFoundException extends BaseCiException {
  ModulesNotFoundException(String message) : super(message);
}

/// Не найден файл.
class FileNotFoundException extends BaseCiException {
  FileNotFoundException(String message) : super(message);
}

/// Ошибка использования неверного формата.
class FormatException extends BaseCiException {
  FormatException(String message) : super(message);
}

/// Базовая ошибка выполнения команд Git
abstract class GitProcessException extends BaseCiException {
  GitProcessException(String message) : super(message);
}

/// Ошибки функционала

/// Build

/// Ошибка при сборке модуля.
///
/// Выбрасывается как в случае сборки единичного модуля так и списка модулей.
class PackageBuildException extends BaseCiException {
  PackageBuildException(String message) : super(message);
}

/// Модуль, помеченный как stable, был изменён.
class StableModulesWasModifiedException extends BaseCiException {
  StableModulesWasModifiedException(String message) : super(message);
}

/// Модуль не прошёл проверку статического анализатора
/// `flutter analyze`
class AnalyzerFailedException extends BaseCiException {
  AnalyzerFailedException(String message) : super(message);
}

/// Модуль поменял значение стабильности в dev ветке.
class StabilityDevChangedException extends BaseCiException {
  StabilityDevChangedException(String message) : super(message);
}

/// Licensing

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

/// Test

/// Тесты в модуле не прошли.
class TestsFailedException extends BaseCiException {
  TestsFailedException(String message) : super(message);
}

/// Publish

/// Не можем опубликовать модуль OpenSource
class OpenSourceModuleCanNotBePublishException extends BaseCiException {
  OpenSourceModuleCanNotBePublishException(String message) : super(message);
}

/// Нет описание версии в CHANGELOG.md
class ChangeLogDoesNotContainCurrentVersionException extends BaseCiException {
  ChangeLogDoesNotContainCurrentVersionException(String message) : super(message);
}

/// CHANGELOG.md содержит кириллицу
class ContainsCyrillicInChangelogException extends BaseCiException {
  ContainsCyrillicInChangelogException(String message) : super(message);
}

/// У модуля отсутствует информация о репозитории с его исходным кодом.
class ModuleIsNotOpenSourceException extends BaseCiException {
  ModuleIsNotOpenSourceException(String message) : super(message);
}

/// Git

/// Ошибка получения hash комита.
class CommitHashException extends GitProcessException {
  CommitHashException(String message) : super(message);
}

/// Ошибка выполнения checkout.
class CheckoutException extends GitProcessException {
  CheckoutException(String message) : super(message);
}

/// Невозможно добавить файл
class GitAddException extends GitProcessException {
  GitAddException(String message) : super(message);
}

/// Невозможно сделать коммит
class CommitException extends GitProcessException {
  CommitException(String message) : super(message);
}

/// Невозможно сделать пуш
class PushException extends GitProcessException {
  PushException(String message) : super(message);
}

/// Ошибка во время зеркалирования модуля в отдельный репозиторий.
class ModuleMirroringException extends GitProcessException {
  ModuleMirroringException(String message) : super(message);
}

/// Ошибка при получении описания ветки.
class GitDescribeException extends GitProcessException {
  GitDescribeException({
    String message = gitDescribeExceptionText,
  }) : super(message);
}

/// Не удалось добавить тег.
class GitAddTagException extends GitProcessException {
  GitAddTagException(String message) : super(message);
}

/// Commands

/// Ошибка парсинга команды
class ParseCommandException extends BaseCiException {
  ParseCommandException(String message) : super(message);
}

/// Ошибка валидации параметров команды
class CommandParamsValidationException extends BaseCiException {
  CommandParamsValidationException(String message) : super(message);
}

/// Не найден обработчик команды
class CommandHandlerNotFoundException extends BaseCiException {
  CommandHandlerNotFoundException(String message) : super(message);
}
