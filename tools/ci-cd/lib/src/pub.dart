import 'dart:io';

const _pubCredentialsKey = 'PUB_CREDENTIALS';

void publishToPub() {
  final pubCachePath = getPubCachePath();
  Directory(pubCachePath).createSync(recursive: true);

  final credential = Platform.environment[_pubCredentialsKey];
  if (credential == null) {
    throw ArgumentError.value(
      credential,
      _pubCredentialsKey,
      'Make sure you setup environment variable',
    );
  }

  File('$pubCachePath/credentials.json').writeAsStringSync(
    credential,
    mode: FileMode.writeOnly,
    flush: true,
  );

  final pubCommands = [
    ['pub', 'publish', '--force'],
  ];

  for (final command in pubCommands) {
    final result = Process.runSync('dart', command);
    stdout.write(result.stdout);
    stderr.write(result.stderr);
    if (result.exitCode != 0) {
      exit(exitCode);
    }
  }
}

const _pubCacheKey = 'PUB_CACHE';

String getPubCachePath() {
  if (Platform.environment.containsKey(_pubCacheKey)) {
    return Platform.environment[_pubCacheKey]!;
  } else if (Platform.operatingSystem == 'windows') {
    return '${Platform.environment['APPDATA']}/Pub/Cache';
  } else {
    return '${Platform.environment['HOME']}/.pub-cache';
  }
}
