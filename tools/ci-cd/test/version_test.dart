@TestOn('vm')
import 'package:ci_cd/src/version.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

void main() {
  test('bumpPackageVersion returns increased dev version', () {
    expect(
      bumpPackageVersion(Version(0, 10, 0)),
      equals(Version(0, 10, 0, pre: 'dev.1')),
    );
    expect(
      bumpPackageVersion(Version(1, 0, 0)),
      equals(Version(1, 0, 0, pre: 'dev.1')),
    );
    expect(
      bumpPackageVersion(Version(1, 2, 3, pre: 'dev.45')),
      equals(Version(1, 2, 3, pre: 'dev.46')),
    );
    expect(
      bumpPackageVersion(Version(1, 2, 3, pre: 'dev')),
      equals(Version(1, 2, 3, pre: 'dev.1')),
    );
  });
}
