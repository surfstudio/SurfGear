// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

@TestOn('vm')
import 'package:ci_cd/src/changelog.dart';
import 'package:ci_cd/src/importance.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

const _changelog = [
  '# Changelog',
  '',
  '## 1.1.1-dev.4 - 2021-05-27',
  '',
  '* Add new rule: [member-ordering-extended](https://github.com/dart-code-checker/dart-code-metrics/blob/master/doc/rules/member-ordering-extended.md) (minor)',
  '',
  '## 1.1.1-dev.3 - 2021-05-25',
  '',
  '* Tune metrics settings (patch)',
  '',
  '## 1.1.1-dev.2 - 2021-05-24',
  '',
  '* Set min SDK version to `2.13.0`. (patch)',
  '* Tune `avoid-returning-widgets`. (patch)',
  '',
  '## 1.1.1-dev.1 - 2021-05-24',
  '',
  '* Add some rules: `avoid_multiple_declarations_per_line`, `deprecated_consistency`, `prefer_if_elements_to_conditional_expressions`, `unnecessary_null_checks`, `unnecessary_nullable_for_final_variable_declarations`, `use_if_null_to_convert_nulls_to_bools`, `use_late_for_private_fields_and_variables`, `use_named_constants`, `missing_whitespace_between_adjacent_strings`, `avoid_type_to_string`, `use_build_context_synchronously`. (minor)',
  '* Disable rules: `sort_child_properties_last`, `sort_constructors_first`, `sort_unnamed_constructors_first`. (minor)',
  '',
  '## 1.1.0',
  '',
  '* Bump pedantic version.',
  '* Add [dart-code-metrics](https://pub.dev/packages/dart_code_metrics) dependency.',
  '',
];

void main() {
  test('getChangesImportanceForStable', () {
    expect(
      getChangesImportanceForStable(_changelog),
      equals(ChangesImportance.minor),
    );

    expect(
      getChangesImportanceForStable([
        '# Changelog',
        '',
        '## 0.0.2 - 2021-03-08',
        '',
        '* Initial release',
        '',
      ]),
      equals(ChangesImportance.unknown),
    );
  });

  group('getChangesImportanceForUnstable returns', () {
    test('unknown for empty changelog', () {
      expect(
        getChangesImportanceForUnstable([]),
        equals(ChangesImportance.unknown),
      );
      expect(
        getChangesImportanceForUnstable(['# Changelog', '']),
        equals(ChangesImportance.unknown),
      );
    });

    test('unknown for changelog without dev block', () {
      expect(
        getChangesImportanceForUnstable([
          '# Changelog',
          '',
          '## 0.0.4-dev.3 - 2021-03-24',
          '',
          '* Fixed loading and error builders on empty stream data',
          '* Update README.md',
        ]),
        equals(ChangesImportance.unknown),
      );
    });

    test('unknown for unknown importance form changelog with dev block', () {
      expect(
        getChangesImportanceForUnstable([
          '# Changelog',
          '',
          '## NEW FEATURE',
          '',
          '* changes',
          '* changes',
        ]),
        equals(ChangesImportance.unknown),
      );
    });

    test('importance for changelog in dev block', () {
      expect(
        getChangesImportanceForUnstable([
          '# Changelog',
          '',
          '## MAJOR',
          '',
          '* changes',
          '* changes',
        ]),
        equals(ChangesImportance.major),
      );
      expect(
        getChangesImportanceForUnstable([
          '# Changelog',
          '',
          '## MINOR',
          '',
          '* changes',
          '* changes',
        ]),
        equals(ChangesImportance.minor),
      );
      expect(
        getChangesImportanceForUnstable([
          '# Changelog',
          '',
          '## PATCH',
          '',
          '* changes',
        ]),
        equals(ChangesImportance.patch),
      );
    });
  });

  test(
    'getDeveloperChangesCount returns count of developer changes introduced in this branch',
    () {
      expect(getDeveloperChangesCount([]), isZero);
      expect(
        getDeveloperChangesCount([
          '# Changelog',
          '',
          '## 0.0.4-dev.3 - 2021-03-08',
          '',
          '* Fixed loading and error builders on empty stream data',
          '* Update README.md',
          '',
          '## 0.0.3 - 2021-03-01',
        ]),
        isZero,
      );
      expect(
        getDeveloperChangesCount([
          '# Changelog',
          '',
          '## MINOR',
          '',
          '## 0.0.4-dev.3 - 2021-03-08',
          '',
          '* Fixed loading and error builders on empty stream data',
          '* Update README.md',
        ]),
        isZero,
      );
      expect(
        getDeveloperChangesCount([
          '# Changelog',
          '',
          '## MINOR',
          '',
          '* changes',
          '',
          '## 0.0.4-dev.3 - 2021-03-08',
          '',
          '* Fixed loading and error builders on empty stream data',
          '* Update README.md',
        ]),
        equals(1),
      );
    },
  );

  test('getLatestStableVersion returns latest stableVersion', () {
    expect(
      getLatestStableVersion(_changelog),
      equals(Version(1, 1, 0)),
    );
    expect(
      getLatestStableVersion([]),
      equals(Version(0, 0, 0)),
    );
  });

  test('getLineImportance returns importance of passed line', () {
    expect(getLineImportance(''), equals(ChangesImportance.unknown));
    expect(
      getLineImportance(
        '* Fixed loading and error builders on empty stream data',
      ),
      equals(ChangesImportance.unknown),
    );
    expect(
      getLineImportance(
        '* Fixed loading and error builders on empty stream data (patch)',
      ),
      equals(ChangesImportance.patch),
    );
    expect(
      getLineImportance(
        '* Fixed loading and error builders on empty stream data (minor)',
      ),
      equals(ChangesImportance.minor),
    );
  });

  test('getPublicationDate returns publication date', () {
    expect(getPublicationDate(_changelog, Version(1, 0, 0)), isNull);
    expect(getPublicationDate(_changelog, Version(1, 1, 0)), isNull);
    expect(
      getPublicationDate(_changelog, Version(1, 1, 1, pre: 'dev.1')),
      equals(DateTime(2021, 05, 24)),
    );
    expect(
      getPublicationDate(_changelog, Version(1, 1, 1, pre: 'dev.2')),
      equals(DateTime(2021, 05, 24)),
    );
    expect(
      getPublicationDate(_changelog, Version(1, 1, 1, pre: 'dev.3')),
      equals(DateTime(2021, 05, 25)),
    );
    expect(
      getPublicationDate(_changelog, Version(1, 1, 1, pre: 'dev.4')),
      equals(DateTime(2021, 05, 27)),
    );
  });

  test(
    'getUnstableReleaseLineIndices returns lines indices with release paragraphs',
    () {
      expect(getUnstableReleaseLineIndices([]), isEmpty);
      expect(
        getUnstableReleaseLineIndices([
          '# Changelog',
          '',
          '## MINOR',
          '',
          '* changes',
          '',
          '## 0.0.4-dev.3 - 2021-03-08',
          '',
          '* Fixed loading and error builders on empty stream data',
          '* Update README.md',
        ]),
        equals([2, 6]),
      );
    },
  );

  test('patchUnstableChangelog returns patched content', () {
    expect(
      patchUnstableChangelog(
        [
          '# Changelog',
          '',
          '## MINOR',
          '',
          '* changes',
          '',
          '## 0.0.4-dev.3 - 2021-03-08',
          '',
          '* Fixed loading and error builders on empty stream data',
          '* Update README.md',
        ],
        Version(1, 0, 0),
        ChangesImportance.major,
        DateTime(2021, 1, 2),
      ),
      equals([
        '# Changelog',
        '',
        '## 1.0.0 - 2021-01-02',
        '',
        '* changes (major)',
        '',
        '## 0.0.4-dev.3 - 2021-03-08',
        '',
        '* Fixed loading and error builders on empty stream data',
        '* Update README.md',
      ]),
    );
  });
}
