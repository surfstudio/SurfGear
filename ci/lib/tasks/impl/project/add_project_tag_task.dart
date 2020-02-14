import 'package:ci/domain/tag.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/process_result_extension.dart';

/// Добавляет проектный тег на текущее состояние ветки.
class AddProjectTagTask extends Action {
  final ProjectTag _projectTag;

  AddProjectTagTask(this._projectTag);

  @override
  Future<void> run() async {
    var tagName = _projectTag.tagName;

    /// Добавляем тег
    var res = await sh('git tag $tagName');

    res.print();

    if (res.exitCode != 0) {
      return Future.error(
        GitAddTagException(
          getGitAddTagExceptionText(
            tagName,
          ),
        ),
      );
    }

    /// Пушим этот тег
    res = await sh('git push origin $tagName');

    res.print();

    if (res.exitCode != 0) {
      return Future.error(
        PushException(
          getGitPushExceptionText(
            'origin $tagName',
          ),
        ),
      );
    }
  }
}
