import 'package:ci/domain/tag.dart';
import 'package:ci/tasks/core/task.dart';

/// Задача, возвращающая представление последнего git тега как проектного тега.
///
/// Возвращает ошибку в случае если тег не найден, или не удалось
/// представить его в виде ProjectTag.
class GetLastProjectTagTask extends Task<ProjectTag> {
  @override
  Future<ProjectTag> run() {
  }
}
