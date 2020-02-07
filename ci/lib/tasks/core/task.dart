import 'package:ci/domain/command.dart';
import 'package:ci/domain/config.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/parsers/command_parser.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:meta/meta.dart';

/// Интерфейс задачи.
abstract class Task<R> {
  Future<R> run();
}

/// Интерфейс задачи проверки.
abstract class Check extends Task<bool> {}

/// Интерфейс задачи без возвращения ответа.
abstract class Action extends Task<void> {}

/// Интерфейс некоторого сценария исполнения команды
abstract class Scenario extends Action {
  final Command command;

  final PubspecParser _pubspecParser;

  Scenario(this.command, this._pubspecParser);

  @override
  Future<void> run() async {
    try {
      await validate(command);
      var list = await preExecute();
      await doExecute(list);
      await postExecute();
    } on BaseCiException {
      rethrow;
    }
  }

  /// Метод для валидации команды.
  @protected
  Future<void> validate(Command command) async {
  }

  /// Вызывается перед исполнением основной части, проводит подготовку и
  /// возвращает список, на котором нужно выполнить сценарий.
  ///
  /// Может быть переопределен, стандартное поведение - список всех элементов.
  @protected
  Future<List<Element>> preExecute() async {
    return _pubspecParser.parsePubspecs(Config.packagesPath);
  }

  /// Основная часть сценария, необходима для определения наследниками.
  /// Должна содержать само исполнение данного сценария
  @protected
  Future<void> doExecute(List<Element> elements);

  /// Вызывается после выполнения основной части сценария.
  ///
  /// Доступна для переопределения, чтобы выполнить некоторые действия после.
  @protected
  Future<void> postExecute() async {
  }
}

/// Сценарий, затрагивающий только 1 элемент.
///
/// Считаем обязательным передачу для такого сценария параметра name в команде.
abstract class OneElementScenario extends Scenario {
  String get formatExceptionText;

  OneElementScenario(Command command, PubspecParser pubspecParser,) : super(command, pubspecParser,);

  @override
  Future<void> validate(Command command) async {
    var elementName = command.arguments[CommandParser.defaultNameOption];

    if (elementName == null) {
      return Future.error(
        CommandParamsValidationException(
          formatExceptionText,
        ),
      );
    }
  }

  @override
  Future<List<Element>> preExecute() async {
    /// получаем все элементы
    var elements = await super.preExecute();

    var elementName = command.arguments[CommandParser.defaultNameOption];

    var element = elements.firstWhere(
          (e) => e.name == elementName,
      orElse: () => null,
    );

    if (element == null) {
      return Future.error(
        ElementNotFoundException(
          getElementNotFoundExceptionText(elementName),
        ),
      );
    }

    return <Element>[element];
  }

  @override
  Future<void> doExecute(List<Element> elements) async {
    try {
      await handleElement(elements[0]);
    } on BaseCiException {
      rethrow;
    }
  }

  Future<void> handleElement(Element element);
}