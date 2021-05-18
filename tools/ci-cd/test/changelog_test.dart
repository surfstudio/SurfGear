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
import 'package:test/test.dart';

void main() {
  test('getChangesImportanceForStable', () {
    expect(
      getChangesImportanceForStable([
        '# Changelog',
        '',
        '## 0.0.4-dev.3 - 2021-03-24',
        '',
        '* Fixed loading and error builders on empty stream data (PATCH)',
        '* Update README.md (PATCH)',
        '',
        '## 0.0.4-dev.1 - 2021-03-24',
        '',
        '* Up rxdart dependency (MINOR)',
        '',
        '## 0.0.2 - 2021-03-08',
        '',
        '* Initial release',
        '',
      ]),
      equals(ChangesImportance.minor),
    );
  });

  group('getDevChangesImportance returns', () {
    test('unknown for empty changelog', () {
      expect(getDevChangesImportance([]), equals(ChangesImportance.unknown));
      expect(
        getDevChangesImportance(['# Changelog', '']),
        equals(ChangesImportance.unknown),
      );
    });

    test('unknown for changelog without dev block', () {
      expect(
        getDevChangesImportance([
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
        getDevChangesImportance([
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
        getDevChangesImportance([
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
        getDevChangesImportance([
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
        getDevChangesImportance([
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
    'getDevChangesCount returns count of developer changes introduced in this branch',
    () {
      expect(getDevChangesCount([]), isZero);
      expect(
        getDevChangesCount([
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
        getDevChangesCount([
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
        getDevChangesCount([
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

  test(
    'getLineImportance returns importance of passed line',
    () {
      expect(getLineImportance(''), equals(ChangesImportance.unknown));
      expect(
        getLineImportance(
            '* Fixed loading and error builders on empty stream data'),
        equals(ChangesImportance.unknown),
      );
      expect(
        getLineImportance(
            '* Fixed loading and error builders on empty stream data (patch)'),
        equals(ChangesImportance.patch),
      );
      expect(
        getLineImportance(
            '* Fixed loading and error builders on empty stream data (minor)'),
        equals(ChangesImportance.minor),
      );
    },
  );

  test(
    'getReleaseLineIndices returns lines indices with release paragraphs',
    () {
      expect(getReleaseLineIndices([]), isEmpty);
      expect(
        getReleaseLineIndices([
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

  test('patchChangelog returns patched content', () {
    expect(
      patchChangelog(
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
        'newVersion',
        ChangesImportance.major,
        DateTime(2021, 1, 2),
      ),
      equals([
        '# Changelog',
        '',
        '## newVersion - 2021-01-02',
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
