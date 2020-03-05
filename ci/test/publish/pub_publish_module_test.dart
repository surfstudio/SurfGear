import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/impl/publish/pub_publish_module_task.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

/// Тестируем класс [PubPublishModuleTask]
void main() {
  group(
    'PubPublishModule tests:',
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
          expectNoThrow(() async {
            await task.run();
          });
        },
      );
    },
  );
}

PubPublishModuleTask _prepareTestTask(bool isError, Element element, {String pathServer}) {
  var pubPublishMock = PubPublishManagerMock();
  when(pubPublishMock.runPubPublish(element))
      .thenAnswer((_) => Future.value(ProcessResult(0, isError ? 1 : 0, '', '')));
  return PubPublishModuleTask(element, pubPublishMock);
}
