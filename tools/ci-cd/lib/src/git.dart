import 'dart:io';

import 'package:pub_semver/pub_semver.dart';

void pushNewVersion({required Version version, required String packageName}) {
  final gitCommands = [
    ['config', 'user.name', 'github-actions'],
    ['config', 'user.email', 'github-actions@github.com'],
    ['add', '.'],
    ['commit', '--message', '🔖 Update $packageName version to $version'],
    [
      'tag',
      '--annotate',
      '$packageName-$version',
      '--message',
      '🔖 Release $packageName version $version',
    ],
    ['push'],
    ['push', 'origin', version.toString()],
  ];

  for (final command in gitCommands) {
    final result = Process.runSync('git', command);
    stdout..writeln('git ${command.join(' ')}')..writeln(result.stdout);
    stderr.writeln(result.stderr);
    if (result.exitCode != 0) {
      exit(exitCode);
    }
  }
}
