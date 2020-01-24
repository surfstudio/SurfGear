import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/tasks/package_builder_task.dart';

/// Набор глобальных точек входа для выполнения задач

/// Выполняет сборку переданных модулей.
Future<void> build(List<Element> elements) async {
  // TODO: проверки на изменение? или получаем сразу проверенный список, стоит подумать и решить

  var failList = <Element>[];
  for (var element in elements) {
    var buildTask = PackageBuilderTask(element, FileSystemManager());
    try {
      await buildTask.run();
    } on PackageBuildException {
      failList.add(element);
    }
  }

  if (failList.isNotEmpty) {
    return Future.error(
      "Не удалось собрать следующие модули: ${failList.join(", ")}",
    );
  }
}
