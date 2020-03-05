import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/scenario.dart';

/// Сценарий для команды publish.
/// Публикует модули на указанный сервер, по умолчанию pub.dev
///
/// Для публикации используется опция [--force]. Важно помнить,
/// что в случаи предупреждений пакет будет загружен. что бы гарантировать,
/// что пакет не будет иметь предупреждений, нужно вызвать перед публикацией [CheckPublishAvailableScenario]
///
/// Пример вызова:
/// dart ci publish / dart ci publish --server=serverAddress /
class PublishModulesScenario extends ChangedElementScenario {
  static const String commandName = 'publish';
  static const String server = 'server';

  PublishModulesScenario(
    Command command,
    PubspecParser pubspecParser,
  ) : super(
          command,
          pubspecParser,
        );

  /// [targetServer] содержит переданный сервер
  @override
  Future<void> doExecute(List<Element> elements) async {
    var targetServer = command.arguments[server];
    try {
      for (var element in elements) {
        await pubPublishModules(element, pathServer: targetServer);
      }
    } on BaseCiException {
      rethrow;
    }
  }

  @override
  String get getCommandName => commandName;

  @override
  String get helpInfo => 'publishes modules to the server';
}
