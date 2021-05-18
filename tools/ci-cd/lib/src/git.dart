import 'dart:io';

import 'package:pub_semver/pub_semver.dart';

void pushNewVersion(Version version) {
  final gitCommands = [
    ['config', 'user.name', 'github-actions'],
    ['config', 'user.email', 'github-actions@github.com'],
    ['add', '.'],
    ['commit', '-m', '🔖 Update version to $version'],
    ['tag', '-a', version.toString(), '-m', '🔖 Release version $version'],
    ['push'],
    ['push', 'origin', version.toString()],
  ];

  for (final command in gitCommands) {
    final result = Process.runSync('git', command);
    stdout.write(result.stdout);
    stderr.write(result.stderr);
    if (result.exitCode != 0) {
      exit(exitCode);
    }
  }
}
