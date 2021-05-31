@TestOn('vm')
import 'package:ci_cd/src/importance.dart';
import 'package:ci_cd/src/version.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

void main() {
  test('bumpPackageVersion returns increased dev version', () {
    expect(
      bumpUnstablePackageVersion(Version(0, 10, 0), ChangesImportance.major),
      equals(Version(1, 0, 0, pre: 'dev.1')),
    );
    expect(
      bumpUnstablePackageVersion(Version(0, 10, 0), ChangesImportance.minor),
      equals(Version(0, 11, 0, pre: 'dev.1')),
    );
    expect(
      bumpUnstablePackageVersion(Version(1, 0, 0), ChangesImportance.patch),
      equals(Version(1, 0, 1, pre: 'dev.1')),
    );
    expect(
      bumpUnstablePackageVersion(Version(1, 0, 0), ChangesImportance.unknown),
      equals(Version(1, 0, 1, pre: 'dev.1')),
    );
    expect(
      bumpUnstablePackageVersion(
        Version(1, 2, 3, pre: 'dev.45'),
        ChangesImportance.minor,
      ),
      equals(Version(1, 2, 3, pre: 'dev.46')),
    );
    expect(
      bumpUnstablePackageVersion(
        Version(1, 2, 3, pre: 'dev'),
        ChangesImportance.patch,
      ),
      equals(Version(1, 2, 3, pre: 'dev.1')),
    );
  });
}
