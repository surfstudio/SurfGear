@TestOn('vm')
import 'package:ci_cd/src/pubspec.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

void main() {
  group('getPackageVersion returns', () {
    test('0.0.0 for empty pubspec', () {
      expect(getPackageVersion([]), equals(Version(0, 0, 0)));
      expect(
        getPackageVersion([
          'name: relation',
          'description: the stream representation of the relations of the entities and widget utilities',
        ]),
        equals(Version(0, 0, 0)),
      );
    });
    test('version from provided pubspec content', () {
      expect(
        getPackageVersion([
          'name: relation',
          'version: 0.10.0-dev.5',
          'description: the stream representation of the relations of the entities and widget utilities',
        ]),
        equals(Version(0, 10, 0, pre: 'dev.5')),
      );
      expect(
        getPackageVersion([
          'name: relation',
          'version:0.10.0-dev.5',
          'description: the stream representation of the relations of the entities and widget utilities',
        ]),
        equals(Version(0, 10, 0, pre: 'dev.5')),
      );
      expect(
        getPackageVersion([
          'name: relation',
          "version: '0.10.0-dev.5'",
          'description: the stream representation of the relations of the entities and widget utilities',
        ]),
        equals(Version(0, 10, 0, pre: 'dev.5')),
      );
      expect(
        getPackageVersion([
          'name: relation',
          'version:"0.10.0-dev.5"',
          'description: the stream representation of the relations of the entities and widget utilities',
        ]),
        equals(Version(0, 10, 0, pre: 'dev.5')),
      );
    });
  });

  test('patchPubspec returns patched content', () {
    expect(patchPubspec([], Version(1, 0, 0)), equals(<String>[]));
    expect(
      patchPubspec(
        [
          'name: relation',
          'description: the stream representation of the relations of the entities and widget utilities',
        ],
        Version(1, 0, 0),
      ),
      equals([
        'name: relation',
        'description: the stream representation of the relations of the entities and widget utilities',
      ]),
    );
    expect(
      patchPubspec(
        [
          'name: relation',
          'version: 0.10.0',
          'description: the stream representation of the relations of the entities and widget utilities',
        ],
        Version(1, 0, 0),
      ),
      equals([
        'name: relation',
        'version: 1.0.0',
        'description: the stream representation of the relations of the entities and widget utilities',
      ]),
    );
  });
}
