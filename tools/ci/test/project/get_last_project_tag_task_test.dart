import 'dart:io';

import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/impl/project/get_last_project_tag_task.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

void main() {
  group('Get last project tag task tests:', () {
    test('Should return correct project tag', () async {
      var callingMap = <String, dynamic>{
        'git describe --tag': ProcessResult(
          0,
          0,
          'project-test-24',
          null,
        ),
      };
      substituteShell(callingMap: callingMap);
      var tag = await GetLastProjectTagTask().run();

      expect(tag.tagName, 'project-test-24');
    });

    test('Exception should be thrown if git describe failed', () async {
      substituteShell(
          callingMap: <String, dynamic>{'git describe --tag': false});
      var task = await GetLastProjectTagTask();

      expect(
        () async => await task.run(),
        throwsA(
          TypeMatcher<GitDescribeException>(),
        ),
      );
    });

    test('Format exception should be thrown if tag is not project tag',
        () async {
      substituteShell(callingMap: <String, dynamic>{
        'git describe --tag': ProcessResult(
          0,
          0,
          'not-a- project-tag',
          null,
        ),
      });
      var task = await GetLastProjectTagTask();

      expect(
        () async => await task.run(),
        throwsA(
          TypeMatcher<FormatException>(),
        ),
      );
    });
  });
}
