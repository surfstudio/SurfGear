import 'package:ci/tasks/impl/git/fix_changes_task.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

void main() {
  group('Fix changes task tests:', () {
    test('Task should call commands in right order', () async {
      var shell = substituteShell();

      var task = FixChangesTask(message: 'test commit message');
      when(shell.run(any, any)).thenAnswer(
        (_) => Future.value(createPositiveResult()),
      );

      await task.run();

      verifyInOrder([
        shell.run('git', ['add', '-A']),
        shell.run('git', ['commit', '-m', 'test commit message']),
        shell.run('git', ['push']),
      ]);
    });
  });
}
