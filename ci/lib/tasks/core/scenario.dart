import 'package:ci/domain/command.dart';
import 'package:ci/domain/config.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:meta/meta.dart';

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
  Future<void> validate(Command command) async {}

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
  Future<void> postExecute() async {}
}
