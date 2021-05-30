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

import 'dart:convert';
import 'dart:io';

import 'package:ci_cd/src/importance.dart';
import 'package:pub_semver/pub_semver.dart';

const _changeMark = '* ';
const _versionMark = '## ';

Iterable<String> readChangelog() {
  final changelog = File('CHANGELOG.md');
  if (!changelog.existsSync()) {
    return [];
  }

  return LineSplitter.split(changelog.readAsStringSync());
}

ChangesImportance getChangesImportanceForUnstable(Iterable<String> changelog) {
  const _importanceMap = {
    '## major': ChangesImportance.major,
    '## minor': ChangesImportance.minor,
    '## patch': ChangesImportance.patch,
  };

  if (changelog.length < 3) {
    return ChangesImportance.unknown;
  }

  final potentialSeverityLine = (changelog.iterator
        ..moveNext()
        ..moveNext()
        ..moveNext())
      .current
      .trim()
      .toLowerCase();

  return _importanceMap[potentialSeverityLine] ?? ChangesImportance.unknown;
}

ChangesImportance getChangesImportanceForStable(Iterable<String> changelog) =>
    changelog.fold(ChangesImportance.unknown, (previousValue, line) {
      final trimmedLine = line.trim();
      if (!trimmedLine.startsWith(_changeMark)) {
        return previousValue;
      }

      final lineImportance = getLineImportance(trimmedLine);

      return lineImportance > previousValue ? lineImportance : previousValue;
    });

int getDeveloperChangesCount(Iterable<String> changelog) {
  if (getChangesImportanceForUnstable(changelog) == ChangesImportance.unknown) {
    return 0;
  }

  final indices = getUnstableReleaseLineIndices(changelog).toList();

  return indices.isNotEmpty
      ? changelog
          .toList()
          .sublist(indices[0] + 1, indices[1])
          .where((line) => line.trim().startsWith(_changeMark))
          .length
      : 0;
}

Version getLatestStableVersion(Iterable<String> changelog) => changelog
    .where((line) => line.startsWith(_versionMark))
    .map((line) => line.substring(_versionMark.length).split(' - ').first)
    .map((line) => Version.parse(line))
    .firstWhere(
      (version) => !version.isPreRelease,
      orElse: () => Version(0, 0, 0),
    );

ChangesImportance getLineImportance(String line) =>
    ChangesImportance.values.firstWhere(
      (values) => line.toLowerCase().endsWith('($values)'),
      orElse: () => ChangesImportance.unknown,
    );

DateTime? getPublicationDate(Iterable<String> changelog, Version version) {
  final date = changelog
      .firstWhere(
        (line) => line.contains(version.toString()),
        orElse: () => '',
      )
      .split(' - ')
      .last;

  return DateTime.tryParse(date);
}

Iterable<int> getUnstableReleaseLineIndices(Iterable<String> content) {
  var lineIndex = 0;

  return content.expand((line) {
    lineIndex++;

    return line.startsWith(_versionMark) ? [lineIndex - 1] : [];
  });
}

Iterable<String> patchUnstableChangelog(
  Iterable<String> originalContent,
  Version newVersion,
  ChangesImportance importance,
  DateTime changesDate,
) {
  final content = originalContent.toList();
  final releaseLineIndexes = getUnstableReleaseLineIndices(content).toList();

  return [
    ...content.sublist(0, 2),
    '$_versionMark$newVersion - ${changesDate.year}-${changesDate.month.toString().padLeft(2, '0')}-${changesDate.day.toString().padLeft(2, '0')}',
    ...content
        .sublist(releaseLineIndexes[0] + 1, releaseLineIndexes[1])
        .map((line) {
      final trimmedLine = line.trim();

      if (trimmedLine.startsWith(_changeMark)) {
        return '$trimmedLine ($importance)';
      }

      return trimmedLine;
    }),
    ...content.sublist(releaseLineIndexes[1]),
  ];
}

void saveChangelog(Iterable<String> content) {
  File('CHANGELOG.md').writeAsStringSync('${content.join('\n')}\n');
}
