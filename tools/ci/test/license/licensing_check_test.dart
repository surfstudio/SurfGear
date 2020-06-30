import 'dart:io';

import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/impl/license/licensing_check.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

void main() {
  group(
    'Licensing check tests:',
    () {
      test(
        'check licensing should throw error when check license file throw error',
        () async {
          var element = createTestElement();
          var lm = LicenseManagerMock();
          var fm = FileSystemManagerMock();
          when(
            fm.getEntitiesInModule(
              element,
              recursive: true,
              filter: lm.isNeedCopyright,
            ),
          ).thenReturn([]);
          var tf = LicenseTaskFactoryMock();
          var task = createFailTask<bool>(
            exception: PackageLicensingException('test'),
          );
          when(tf.createLicenseFileCheck(element, lm, fm)).thenReturn(task);

          var checkTask = LicensingCheck(element, lm, fm, tf);

          expect(
            () async {
              await checkTask.run();
            },
            throwsA(
              TypeMatcher<PackageLicensingException>(),
            ),
          );
        },
      );

      test(
        'check licensing should throw error when check copyright file throw error',
        () async {
          var element = createTestElement();
          var dartFile = File(
            'testFile.dart',
          );
          var lm = LicenseManagerMock();
          when(lm.isNeedCopyright(dartFile)).thenReturn(true);
          var fm = FileSystemManagerMock();
          when(
            fm.getEntitiesInModule(
              element,
              recursive: true,
              filter: lm.isNeedCopyright,
            ),
          ).thenReturn(
            [dartFile],
          );
          var tf = LicenseTaskFactoryMock();
          var checkLicenseTask = createSuccessTask(result: true);
          when(
            tf.createLicenseFileCheck(
              element,
              lm,
              fm,
            ),
          ).thenReturn(
            checkLicenseTask,
          );
          var checkCopyrightTask = createFailTask<bool>(
            exception: PackageLicensingException('test'),
          );
          when(
            tf.createCopyrightCheck(
              'testFile.dart',
              fm,
              lm,
            ),
          ).thenReturn(
            checkCopyrightTask,
          );

          var checkTask = LicensingCheck(element, lm, fm, tf);

          expect(
            () async {
              await checkTask.run();
            },
            throwsA(
              TypeMatcher<PackageLicensingException>(),
            ),
          );
        },
      );

      test(
        'check licensing should not throw error when all check throw no error',
        () async {
          var element = createTestElement();
          var dartFile = File(
            'testFile.dart',
          );
          var lm = LicenseManagerMock();
          when(lm.isNeedCopyright(dartFile)).thenReturn(true);
          var fm = FileSystemManagerMock();
          when(
            fm.getEntitiesInModule(
              element,
              recursive: true,
              filter: lm.isNeedCopyright,
            ),
          ).thenReturn(
            [dartFile],
          );
          var tf = LicenseTaskFactoryMock();
          var task = createSuccessTask(result: true);
          when(
            tf.createLicenseFileCheck(
              element,
              lm,
              fm,
            ),
          ).thenReturn(task);
          when(
            tf.createCopyrightCheck(
              'testFile.dart',
              fm,
              lm,
            ),
          ).thenReturn(task);

          var checkTask = LicensingCheck(element, lm, fm, tf);

          expectNoThrow(
            () async {
              await checkTask.run();
            },
          );
        },
      );
    },
  );
}
