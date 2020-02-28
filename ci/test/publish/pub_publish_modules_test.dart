import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/impl/publish/pub_publish_modules.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

void main() {
  group(
    'PubPublishModules tests:',
    () {
      test(
        'Exception should be thrown when module not ready to publish.',
        () async {
          var task = _prepareTestTask(
            true,
            createTestElement(),
          );

          expect(
            () async => await task.run(),
            throwsA(TypeMatcher<OpenSourceModuleCanNotBePublishException>()),
          );
        },
      );
      test(
        'If the module is published, it should return void',
        () async {
          var task = _prepareTestTask(
            false,
            createTestElement(),
          );

          expect(
            () async => await task.run(),
            isA<void>(),
          );
        },
      );
    },
  );
}

PubPublishModules _prepareTestTask(bool isError, Element element, {String pathServer}) {
  var urlServer = pathServer == null ? '' : '--server $pathServer';
  var callingMap = <String, dynamic>{
    'pub publish $urlServer': !isError,
  };
  var shell = substituteShell(callingMap: callingMap);
  var shm = getTestShellManager();
  when(shm.copy(any)).thenReturn(shell);
  return PubPublishModules(element);
}
