import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/impl/license/license_file_check.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

void main() {
  test(
    'check license on module without license should throw special exception',
    () async {
      var element = createTestElement();
      var lm = LicenseManagerMock();
      when(lm.licenseFileName).thenReturn('license');

      var fm = FileSystemManagerMock();
      when(fm.isExist(join(element.path, 'license'))).thenReturn(false);

      var checkTask = LicenseFileCheck(element, lm, fm);

      expect(
        () async {
          await checkTask.run();
        },
        throwsA(
          TypeMatcher<LicenseFileNotFoundException>(),
        ),
      );
    },
  );

  test(
    'check license when sample license not set should throw special exception',
    () async {
      var element = createTestElement();
      var lm = LicenseManagerMock();
      when(lm.licenseFileName).thenReturn('license');
      when(lm.getLicense())
          .thenAnswer((_) => Future.error(LicenseSampleNotFoundException()));

      var fm = FileSystemManagerMock();
      when(fm.isExist(join(element.path, 'license'))).thenReturn(true);

      var checkTask = LicenseFileCheck(element, lm, fm);

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
    'check license when license obsolete should throw special exception',
    () async {
      var checkTask = _licenseTest(
        'actual license',
        'not actual license',
      );

      expect(
        () async {
          await checkTask.run();
        },
        throwsA(
          TypeMatcher<LicenseFileObsoleteException>(),
        ),
      );
    },
  );

  test(
    'check license with actual license should not throw special exception',
    () async {
      var checkTask = _licenseTest(
        'actual license',
        'actual license',
      );

      expectNoThrow(
        () async {
          await checkTask.run();
        },
      );
    },
  );

  test(
    'check license with actual license should return true',
    () async {
      var checkTask = _licenseTest(
        'actual license',
        'actual license',
      );

      expect(
        await checkTask.run(),
        true,
      );
    },
  );
}

LicenseFileCheck _licenseTest(String license, String fileLicense) {
  var element = createTestElement();
  var licensePath = join(element.path, 'license');

  var lm = LicenseManagerMock();
  when(lm.licenseFileName).thenReturn('license');
  when(lm.getLicense()).thenAnswer((_) => Future.value(license));

  var fm = FileSystemManagerMock();
  when(fm.isExist(licensePath)).thenReturn(true);
  when(fm.readFileAsString(licensePath)).thenReturn(fileLicense);

  var checkTask = LicenseFileCheck(element, lm, fm);

  return checkTask;
}
