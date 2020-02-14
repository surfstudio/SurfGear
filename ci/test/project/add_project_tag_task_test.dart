import 'package:ci/domain/tag.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/impl/project/add_project_tag_task.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

void main() {
  group('Add project tag task tests:', () {
    test('Task should call commands in right order', () async {
      var shell = substituteShell();

      var task = AddProjectTagTask(ProjectTag('project-test', 1));
      when(shell.run(any, any)).thenAnswer(
        (_) => Future.value(createPositiveResult()),
      );

      await task.run();

      verifyInOrder([
        shell.run('git', ['tag', 'project-test-1']),
        shell.run('git', ['push', 'origin', 'project-test-1']),
      ]);
    });

    test('If tag add was failed should throw correct exception', () async {
      var callingMap = <String, dynamic>{
        'git tag project-test-1': false,
      };

      _testGitFails(
        callingMap,
        throwsA(
          TypeMatcher<GitAddTagException>(),
        ),
      );
    });

    test('If tag push was failed should throw correct exception', () async {
      var callingMap = <String, dynamic>{
        'git tag project-test-1': true,
        'git push origin project-test-1': false,
      };

      _testGitFails(
        callingMap,
        throwsA(
          TypeMatcher<PushException>(),
        ),
      );
    });
  });
}

void _testGitFails(Map<String, dynamic> callingMap, matcher) {
  substituteShell(callingMap: callingMap);

  var task = AddProjectTagTask(ProjectTag('project-test', 1));

  expect(() async => await task.run(), matcher);
}
