import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/pub_dry_run_task.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'core/test_helper.dart';

void main() {
  group(
    'Is the module OpenSource:',
    () {
      test(
        'Is OpenSource.',
        () async {
          var task = _prepareTestTask(
            true,
            _openSourceTestElement(),
          );
          var actual = await task.run();

          expect(
            actual,
            isTrue,
          );
        },
      );

      test(
        'Isn\'t open source.',
        () async {
          var task = _prepareTestTask(
            true,
            createTestElement(),
          );
          var actual = await task.run();

          expect(
            actual,
            isFalse,
          );
        },
      );
    },
  );

  group(
    'A module that is not ready for publication throws an error:',
    () {
      test(
        'Is OpenSource but not ready for publication.',
        () async {
          var task = _prepareTestTask(
            false,
            _openSourceTestElement(),
          );

          expect(
            () async => await task.run(),
            throwsA(
              TypeMatcher<OpenSourceModuleCanNotBePublishException>(),
            ),
          );
        },
      );
    },
  );
}

PubDryRunTask _prepareTestTask(bool isError, Element element) {
  var callingMap = <String, dynamic>{
    'pub publish --dry-run': isError,
  };
  var shell = substituteShell(callingMap: callingMap);
  var shm = getTestShellManager();
  when(shm.copy(any)).thenReturn(shell);
  return PubDryRunTask(element);
}

Element _openSourceTestElement() => createTestElement(
      openSourceInfo: OpenSourceInfo(
        hostUrl: 'https://www.test.com/opensourceinfo',
        separateRepoUrl: 'https://pub.test/test/opensourceinfo',
      ),
    );
