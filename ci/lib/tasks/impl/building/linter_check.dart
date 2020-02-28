import 'package:ci/domain/element.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';

/// Проверка модуля с помощью `flutter analyze`.
/// Выбрасывает вывод команды, если проверка провалилась,
/// иначе возвращает true.
class CheckModuleWithLinter implements Check {
  final Element element;

  CheckModuleWithLinter(this.element);

  @override
  Future<bool> run() async {
    final analyzeResult = await sh(
      'flutter analyze',
      path: element.path,
    );

    if (analyzeResult.exitCode != 0) {
      final errorMessage = '${analyzeResult.stdout}${analyzeResult.stderr}\n\n';
      throw errorMessage;
    }

    return true;
  }
}
