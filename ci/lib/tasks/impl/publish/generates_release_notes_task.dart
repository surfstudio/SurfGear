import 'dart:io';

import 'package:ci/domain/config.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/process_result_extension.dart';
import 'package:path/path.dart';

/// Файл, который читаем
const String _changelog = 'CHANGELOG.md';
const String _message = 'update RELEASE_NOTES.md file';

/// Создаём файл RELEASE_NOTES.md, который содержит CHANGELOG.md из всех библиотек
class GeneratesReleaseNotesTask extends Action {
  final List<Element> _elements;

  /// Путь до файла RELEASE_NOTES.md
  final String _releaseNote = Config.releaseNoteFilePath;
  final FileSystemManager _fileSystemManager;

  GeneratesReleaseNotesTask(
    this._elements,
    this._fileSystemManager,
  ) : assert(_elements != null && _fileSystemManager != null);

  @override
  Future<void> run() async {
    var strFile = await _generateChangeLog();
    await _fileSystemManager.writeToFileAsString(
      _releaseNote,
      strFile,
      mode: FileMode.write,
    );

    try {
      await _handleResult(
        await sh('git add $_releaseNote'),
        GitAddException(
          getGitAddExceptionText(_releaseNote),
        ),
      );

      await _handleResult(
        await sh('git commit -m', arguments: [_message]),
        CommitException(
          getGitCommitExceptionText(_releaseNote),
        ),
      );

      await _handleResult(
        await sh('git push'),
        PushException(
          getGitPushExceptionText(_releaseNote),
        ),
      );
    } on GitProcessException {
      rethrow;
    }
  }

  /// Считываем все CHANGELOG.md
  Future<String> _generateChangeLog() async {
    var strFile = '';
    for (var element in _elements) {
      strFile = strFile + '# ' + element.name.toString();
      strFile = strFile +
          await _fileSystemManager
              .readFileAsString(join(element.path, _changelog));
    }
    return strFile;
  }

  Future<void> _handleResult(
      ProcessResult processResult, GitProcessException error) async {
    processResult.print();
    if (processResult.exitCode != 0) {
      return Future.error(error);
    }
  }
}
