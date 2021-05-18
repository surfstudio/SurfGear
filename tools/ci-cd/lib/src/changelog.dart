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

const _changeMark = '* ';
const _versionMark = '## ';

Iterable<String> readChangelog() {
  final changelog = File('CHANGELOG.md');
  if (!changelog.existsSync()) {
    return [];
  }

  return LineSplitter.split(changelog.readAsStringSync());
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

int getDevChangesCount(Iterable<String> changelog) {
  if (getDevChangesImportance(changelog) == ChangesImportance.unknown) {
    return 0;
  }

  final indices = getReleaseLineIndices(changelog).toList();

  return indices.isNotEmpty
      ? changelog
          .toList()
          .sublist(indices[0] + 1, indices[1])
          .where((line) => line.trim().startsWith(_changeMark))
          .length
      : 0;
}

ChangesImportance getDevChangesImportance(Iterable<String> changelog) {
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

ChangesImportance getLineImportance(String line) =>
    ChangesImportance.values.firstWhere(
      (values) => line.toLowerCase().endsWith('($values)'),
      orElse: () => ChangesImportance.unknown,
    );

Iterable<int> getReleaseLineIndices(Iterable<String> content) {
  var lineIndex = 0;

  return content.expand((line) {
    lineIndex++;

    return line.startsWith(_versionMark) ? [lineIndex - 1] : [];
  });
}

Iterable<String> patchChangelog(
  Iterable<String> originalContent,
  String newVersion,
  ChangesImportance importance,
  DateTime changesDate,
) {
  final content = originalContent.toList();
  final releaseLineIndexes = getReleaseLineIndices(content).toList();

  final patchedContent = [
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

  return patchedContent;
}

void saveChangelog(Iterable<String> content) {
  File('CHANGELOG.md').writeAsStringSync('${content.join('\n')}\n');
}
