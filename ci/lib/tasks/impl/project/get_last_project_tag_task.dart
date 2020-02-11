import 'package:ci/domain/tag.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/process_result_extension.dart';

/// Задача, возвращающая представление последнего git тега как проектного тега.
///
/// Возвращает ошибку в случае если тег не найден, или не удалось
/// представить его в виде ProjectTag.
// TODO: @zotyev покрыть тестами
class GetLastProjectTagTask extends Task<ProjectTag> {
  @override
  Future<ProjectTag> run() async {
    /// опция тег обязательна, иначе вернется только последняя
    /// аннотированная пометка
    var res = await sh('git describe --tag');

    res.print();

    if (res.exitCode != 0) {
      return Future.error(GitDescribeException());
    }

    try {
      return ProjectTag.parseFrom(res.stdout);
    } on FormatException {
      rethrow;
    }
  }
}
