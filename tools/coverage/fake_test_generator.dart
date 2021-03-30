import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as p;

const _fakeTestPath = 'test/fake_test.dart';
const _folderWithSources = 'lib';

void main(List<String> args) {
  final uncoveredFiles =
      _findSourceFiles(Directory(_folderWithSources)).map((f) => f.path);

  final dartPackage = args.last == 'dart';

  File(_fakeTestPath).writeAsStringSync(_fakeTest(uncoveredFiles, dartPackage),
      mode: FileMode.writeOnly);
}

String _fakeTest(Iterable<String> uncoveredFiles, bool dartPackage) {
  final buffer = StringBuffer()
    ..writeln("import 'package:flutter_test/flutter_test.dart';")
    ..writeln();

  for (final file in uncoveredFiles) {
    buffer.writeln("import '../$file' as ${_getRandomString(8)};");
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
        p.basename(fileOrDir.path) != 'packages') {
      sourceFiles.addAll(_findSourceFiles(fileOrDir));
    }
  }

  return sourceFiles;
}

bool _isSourceFileHaveValidExtension(File file) =>
    p.extension(file.path).endsWith('.dart');

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
