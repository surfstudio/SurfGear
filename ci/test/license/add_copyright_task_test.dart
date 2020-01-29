import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/impl/license/add_copyright_task.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

void main() {
  test(
    'add copyright when file not exist should throw special exception',
    () async {
      var path = 'test/file/path';
      var lm = LicenseManagerMock();
      var fm = FileSystemManagerMock();
      when(fm.isExist(path)).thenReturn(false);

      var checkTask = AddCopyrightTask(path, lm, fm);

      expect(
        () async {
          await checkTask.run();
        },
        throwsA(
          TypeMatcher<FileNotFoundException>(),
        ),
      );
    },
  );

  test(
    'add copyright when sample copyright not set should throw special exception',
    () async {
      var path = 'test/file/path';
      var fm = FileSystemManagerMock();
      when(fm.isExist(path)).thenReturn(true);
      var lm = LicenseManagerMock();
      when(lm.getCopyright())
          .thenAnswer((_) => Future.error(CopyrightSampleNotFoundException()));

      var checkTask = AddCopyrightTask(path, lm, fm);

      expect(() async {
        await checkTask.run();
      }, throwsA(TypeMatcher<CopyrightSampleNotFoundException>()));
    },
  );

  test(
    'add copyright should add copyright to file',
    () async {
      var path = 'test/file/path';
      var fm = FileSystemManagerMock();
      when(fm.isExist(path)).thenReturn(true);
      when(fm.readFileAsString(path)).thenReturn('content');
      var lm = LicenseManagerMock();
      when(lm.getCopyright()).thenAnswer(
        (_) => Future.value('copyright'),
      );

      var checkTask = AddCopyrightTask(path, lm, fm);
      await checkTask.run();

      verify(
        fm.writeToFileAsString(
          path,
          'copyrightcontent'
        ),
      ).called(1);
    },
  );
}
