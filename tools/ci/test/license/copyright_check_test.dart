import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/impl/license/copyright_check.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

void main() {
  group(
    'Copyright check tests:',
    () {
      test(
        'check copyright on file that no exist should throw special exception',
        () async {
          var path = 'test/path';
          var fm = FileSystemManagerMock();
          when(fm.isExist(path)).thenReturn(false);

          var checkTask = CopyrightCheck(path, fm, LicenseManagerMock());

          expect(() async {
            await checkTask.run();
          }, throwsA(TypeMatcher<FileNotFoundException>()));
        },
      );

      test(
        'check copyright when sample copyright not set should throw special exception',
        () async {
          var path = 'test/path';
          var fm = FileSystemManagerMock();
          when(fm.isExist(path)).thenReturn(true);
          var lm = LicenseManagerMock();
          when(lm.getCopyright()).thenAnswer(
              (_) => Future.error(CopyrightSampleNotFoundException()));

          var checkTask = CopyrightCheck(path, fm, lm);

          expect(() async {
            await checkTask.run();
          }, throwsA(TypeMatcher<CopyrightSampleNotFoundException>()));
        },
      );

      test(
        'check file without copyright should throw special exception',
        () async {
          var checkTask = _copyrightTest(
            'copyright',
            '',
          );

          expect(() async {
            await checkTask.run();
          }, throwsA(TypeMatcher<FileCopyrightMissedException>()));
        },
      );

      test(
        'check file with obsolete copyright should throw special exception',
        () async {
          var checkTask = _copyrightTest(
            'very new Copyright (c)',
            'very old Copyright (c)',
          );

          expect(() async {
            await checkTask.run();
          }, throwsA(TypeMatcher<FileCopyrightObsoleteException>()));
        },
      );

      test(
        'check file with actual copyright should not throw exception',
        () async {
          var checkTask = _copyrightTest(
            'copyright',
            'copyright',
          );

          expectNoThrow(() async {
            await checkTask.run();
          });
        },
      );

      test(
        'check file with actual copyright should return true',
        () async {
          var checkTask = _copyrightTest(
            'copyright',
            'copyright',
          );

          expect(await checkTask.run(), true);
        },
      );
    },
  );
}

CopyrightCheck _copyrightTest(String copyright, String fileCopyright) {
  var path = 'test/path';
  var fm = FileSystemManagerMock();
  when(fm.isExist(path)).thenReturn(true);
  when(fm.readFileAsString(path)).thenReturn(
    fileCopyright + 'test file content',
  );
  var lm = createLicenseManagerMock(copyright: copyright);

  var checkTask = CopyrightCheck(path, fm, lm);

  return checkTask;
}
