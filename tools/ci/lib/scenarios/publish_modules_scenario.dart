import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/managers/version_manager.dart';
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
  static final VersionManager _versionManager = VersionManager();

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
    StringBuffer _buffer;

    print("Stable packages: ${releaseElements.map((p) => p.name).join(',')}");
    try {
      var failedModulesNames = <String>[];

      for (var element in releaseElements) {
        /// Сверять версию с pub
        try {
          final isNewVersion = await _versionManager.checkIsNewVersion(
            element.name,
            element.version,
          );

          if (!isNewVersion) {
            print(
                'package ${element.name} v${element.version}: the local package has the same version');
            continue;
          }

          await pubPublishModules(element, pathServer: targetServer);
          print(element.name + ' published');
        } on OpenSourceModuleCanNotBePublishException catch (e) {
          _buffer ??= StringBuffer('failed packages:');
          _buffer.write('\n${element.name}');

          print(e);
          failedModulesNames.add(element.name);
          continue;
        }
      }

      if (elements.length == failedModulesNames.length) {
        throw OpenSourceModuleCanNotBePublishException(
          getModuleCannotBePublishedExceptionText(failedModulesNames.join(',')),
        );
      } else if (_buffer != null) {
        print(_buffer.toString());
      }
    } on BaseCiException {
      rethrow;
    }
  }

  @override
  String get getCommandName => commandName;
}
