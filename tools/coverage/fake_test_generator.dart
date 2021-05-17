import 'dart:io';
import 'dart:math';

const _fakeTestPath = 'test/fake_test.dart';
const _folderWithSources = 'lib/';

void main(List<String> args) {
  final packageName = _getPackageName();

  final uncoveredFiles =
      _findSourceFiles(Directory(_folderWithSources)).map((f) => f.path);

  final dartPackage = args.isNotEmpty && args.last == 'dart';

  File(_fakeTestPath).writeAsStringSync(
      _fakeTest(uncoveredFiles, packageName, dartPackage),
      mode: FileMode.writeOnly);
}

String _fakeTest(
  Iterable<String> uncoveredFiles,
  String? packageName,
  bool dartPackage,
) {
  final buffer = StringBuffer()
    ..writeln(dartPackage
        ? "import 'package:test/test.dart';"
        : "import 'package:flutter_test/flutter_test.dart';")
    ..writeln();

  for (final file in uncoveredFiles) {
    if (packageName != null) {
      buffer.writeln(
          "import 'package:$packageName/${file.startsWith(_folderWithSources) ? file.substring(_folderWithSources.length) : file}' as ${_getRandomString(8)};");
    } else {
      buffer.writeln("import '../$file' as ${_getRandomString(8)};");
    }
  }

  buffer
    ..writeln()
    ..writeln('void main() {')
    ..writeln("  test('stub', () {});")
    ..writeln('}');

  return buffer.toString();
}

Iterable<File> _findSourceFiles(Directory directory) {
  final sourceFiles = <File>[];
  for (final fileOrDir in directory.listSync()) {
    if (fileOrDir is File &&
        _isSourceFileHaveValidExtension(fileOrDir) &&
        _isSourceFileNotPartOfLibrary(fileOrDir)) {
      sourceFiles.add(fileOrDir);
    } else if (fileOrDir is Directory &&
        fileOrDir.path.split('/').last != 'packages') {
      sourceFiles.addAll(_findSourceFiles(fileOrDir));
    }
  }

  return sourceFiles;
}

String? _getPackageName() {
  final pubspec = File('pubspec.yaml');
  if (pubspec.existsSync()) {
    return pubspec
        .readAsLinesSync()
        .firstWhere((line) => line.contains('name:'))
        .split(':')
        .last
        .trim();
  }

  return null;
}

bool _isSourceFileHaveValidExtension(File file) => file.path.endsWith('.dart');

bool _isSourceFileNotPartOfLibrary(File file) =>
    file.readAsLinesSync().every((line) => !line.startsWith('part of '));

const _chars = 'abcdefghijklmnopqrstuvwxyz';

String _getRandomString(int length) {
  final rnd = Random();

  return String.fromCharCodes(Iterable.generate(
    length,
    (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length)),
  ));
}
