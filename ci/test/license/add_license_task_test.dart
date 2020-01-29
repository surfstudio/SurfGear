import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/impl/license/add_license_task.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

void main() {
  test(
    'add license when sample license not set should throw special exception',
    () async {
      var element = createTestElement();
      var lm = LicenseManagerMock();
      when(lm.getLicense()).thenAnswer(
        (_) => Future.error(
          LicenseSampleNotFoundException(),
        ),
      );

      var fm = FileSystemManagerMock();

      var checkTask = AddLicenseTask(element, lm, fm);

      expect(
        () async {
          await checkTask.run();
        },
        throwsA(
          TypeMatcher<LicenseSampleNotFoundException>(),
        ),
      );
    },
  );

  test(
    'add license should add license to module',
    () async {
      var element = createTestElement();
      var licensePath = join(element.path, 'license');

      var lm = LicenseManagerMock();
      when(lm.licenseFileName).thenReturn('license');
      when(lm.getLicense()).thenAnswer(
        (_) => Future.value('license sample'),
      );

      var fm = FileSystemManagerMock();

      var checkTask = AddLicenseTask(element, lm, fm);
      await checkTask.run();

      verify(fm.writeToFileAsString(licensePath, 'license sample')).called(1);
    },
  );
}
