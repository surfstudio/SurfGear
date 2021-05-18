import 'dart:convert';
import 'dart:io';

import 'package:pub_semver/pub_semver.dart';

Iterable<String> readPubspec() {
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    return [];
  }

  return LineSplitter.split(pubspec.readAsStringSync());
}

void savePubspec(Iterable<String> content) {
  File('pubspec.yaml').writeAsStringSync('${content.join('\n')}\n');
}

Version getPackageVersion(Iterable<String> pubspec) {
  const versionPattern = 'version:';

  final versionString = pubspec
      .firstWhere(
        (line) => line.trim().startsWith(versionPattern),
        orElse: () => '$versionPattern 0.0.0',
      )
      .substring(versionPattern.length + 1);

  return Version.parse(versionString);
}

Iterable<String> patchPubspec(
  Iterable<String> originalContent,
  Version newVersion,
) {
  const versionPattern = 'version:';

  final patchedContent = originalContent.map((line) {
    if (line.startsWith(versionPattern)) {
      return '$versionPattern $newVersion';
    }

    return line;
  });

  return patchedContent;
}
