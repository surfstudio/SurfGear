import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/process_result_extension.dart';

const String _defaultCommitMessage = 'Changes by ci.';

/// Задача фиксирования изменений в git.
class FixChangesTask extends Action {
  final String message;

  FixChangesTask({this.message = _defaultCommitMessage});

  @override
  Future<void> run() async {
    var res = await sh('git add -A');
    res.print();

    if (res.exitCode != null) {
      return Future.error(
        GitAddException(
          getGitAddExceptionText('-A'),
        ),
      );
    }

    res = await sh('git commit -m  $message');
    res.print();

    if (res.exitCode != null) {
      return Future.error(
        CommitException(
          getGitCommitExceptionText(''),
        ),
      );
    }

    res = await sh('git push');
    res.print();

    if (res.exitCode != null) {
      return Future.error(
        PushException(
          getGitPushExceptionText(''),
        ),
      );
    }
  }
}
