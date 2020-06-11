import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/tasks.dart';

/// Сценарий для команды publish.
/// Публикует модули на указанный сервер, по умолчанию pub.dev
///
/// Для публикации используется опция [--force].
/// В случае, если пакет имеет предупреждения, а не ошибки модуль все равно будет опубликован.
///
/// Пример вызова:
/// dart ci publish / dart ci publish --server=serverAddress /
class PublishModulesScenario extends ChangedElementScenario {
  static const String commandName = 'publish';
  static const String server = 'server';
  static const String helpServer = 'Server for publish module.';

  @override
  Map<String, String> getCommandsHelp() => {
        commandName: 'Publishes modules to the server.',
      };

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
    var releaseElements = elements.where((e) => e.isStable).toList();

    print("Stable packages: ${releaseElements.map((p) => p.name).join(',')}");
    try {
      var failedModulesNames = <String>[];

      for (var element in releaseElements) {
        try {
          await pubPublishModules(element, pathServer: targetServer);
          print(element.name + ' published');
        } on OpenSourceModuleCanNotBePublishException catch (e) {
          print(e);
          failedModulesNames.add(element.name);
          continue;
        }
      }
      
      if (failedModulesNames.isNotEmpty) {
        throw OpenSourceModuleCanNotBePublishException(
          getModuleCannotBePublishedExceptionText(failedModulesNames.join(',')),
        );
      }
    } on BaseCiException {
      rethrow;
    }
  }

  @override
  String get getCommandName => commandName;
}
