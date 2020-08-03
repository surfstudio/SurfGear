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
/// dart ci publish / dart ci publish --server=serverAddress / is_stable=true/false
class PublishModulesScenario extends ChangedElementScenario {
  static const String commandName = 'publish';
  static const String server = 'server';
  static const String helpServer = 'Server for publish module.';
  static const String isStableOptionName = 'is_stable';
  static final VersionManager _versionManager = VersionManager();

  var _isPublishStable = false;

  @override
  Map<String, String> getCommandsHelp() => {
        commandName: 'Publishes modules to the server.',
        isStableOptionName: 'Publish a stable / unstable module(true/false)',
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
    var releaseElements = elements.where((e) {
      return _isPublishStable ? e.isStable : !e.isStable;
    }).toList();
    StringBuffer _bufferSameVersion;
    StringBuffer _bufferError;

    print(
        "${_isPublishStable ? 'stable' : 'unstable'} packages: ${releaseElements.map((p) => p.name).join(',')}");
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
            _bufferSameVersion ??=
                StringBuffer('Packages with the same version:');
            _bufferSameVersion.write('$element.name v${element.version}');
            continue;
          }

          await pubPublishModules(element, pathServer: targetServer);
        } on OpenSourceModuleCanNotBePublishException catch (e) {
          _bufferError ??= StringBuffer('failed packages:');
          _bufferError.write('\n${element.name}');

          print(e);
          failedModulesNames.add(element.name);
          continue;
        }
      }

      if (_bufferSameVersion != null) print(_bufferSameVersion.toString());
      if (_bufferError != null) print(_bufferError.toString());

      if (elements.length == failedModulesNames.length) {
        throw OpenSourceModuleCanNotBePublishException(
          getModuleCannotBePublishedExceptionText(failedModulesNames.join(',')),
        );
      }
    } on BaseCiException {
      rethrow;
    }
  }

  @override
  Future<void> validate(Command command) {
    var args = command.arguments;

    /// валидация аргументов
    var isStable = args[isStableOptionName];

    if (isStable == null || isStable == 'false') {
      print('Unstable modules publish mode on');
      _isPublishStable = false;
      return Future.value();
    }

    print('Stable modules publish mode on');
    _isPublishStable = true;
    return Future.value();
  }

  @override
  String get getCommandName => commandName;
}
