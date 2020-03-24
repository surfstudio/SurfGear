import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/impl/project/get_last_project_tag_task.dart';
import 'package:ci/tasks/tasks.dart';

/// Сценарий для команды upgrade_project_tag.
///
/// Пример вызова:
/// dart ci upgrade_project_tag
class UpgradeProjectTagScenario extends Scenario {
  static const String commandName = 'upgrade_project_tag';

  @override
  Map<String, String> getCommandsHelp() => {
        commandName: 'Returning representation of the last git tag as a project tag.',
      };

  UpgradeProjectTagScenario(
    Command command,
    PubspecParser pubspecParser,
  ) : super(
          command,
          pubspecParser,
        );

  @override
  Future<void> doExecute(List<Element> elements) async {
    try {
      /// получаем последний тег
      var tag = await GetLastProjectTagTask().run();

      /// выполняем инкремент тега
      tag = tag.inc();

      /// обновляем элементы по новому тегу
      var updated = await updateDependenciesByTag(elements, tag);

      /// сохраняем изменения
      await saveElements(updated);

      /// фиксируем изменения на репозитории
      await fixChanges(message: 'Upgrade project tag by ci: ${tag.tagName}');

      /// добавляем новый тег на изменения
      await addTag(tag);
    } on BaseCiException {
      rethrow;
    }
  }

  @override
  String get getCommandName => commandName;
}
