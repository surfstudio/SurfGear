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
    await _fileSystemManager.writeToFileAsString(_releaseNote, strFile, mode: FileMode.write);
    try {
      await _commit();
    } on GitProcessException {
      rethrow;
    }
  }

  /// Считываем все CHANGELOG.md
  Future<String> _generateChangeLog() async {
    var strFile = '';
    for (var element in _elements) {
      strFile = strFile + '# ' + element.name.toString();
      strFile = strFile + await _fileSystemManager.readFileAsString(join(element.path, _changelog));
    }
    return strFile;
  }

  /// Коммитим результат
  Future<void> _commit() async {
    var processResult = await sh('git add ../RELEASE_NOTES.md');
    if (processResult.exitCode != 0) {
      return _exceptionProcessResultGitAdd(processResult);
    }
    processResult = await sh("git commit -m 'update RELEASE_NOTES.md file'");
    if (processResult.exitCode != 0) {
      return _exceptionProcessResultGitCommit(processResult);
    }
    processResult = await sh('git push origin master');
    if (processResult.exitCode != 0) {
      return _exceptionProcessResultGitPush(processResult);
    }
  }

  /// Выводим в консоль [ProcessResult] и ошибку: добавление файла в git
  Future<void> _exceptionProcessResultGitAdd(ProcessResult processResult) async {
    processResult.print();
    return Future.error(
      GitAddException(
        getCommitExceptionTextGitAdd(_releaseNote),
      ),
    );
  }

  /// Выводим в консоль [ProcessResult] и ошибку: коммит файла в git
  Future<void> _exceptionProcessResultGitCommit(ProcessResult processResult) async {
    processResult.print();
    return Future.error(
      CommitException(
        getCommitExceptionTextGitCommit(_releaseNote),
      ),
    );
  }

  /// Выводим в консоль [ProcessResult] и ошибку: push в репозиторий
  Future<void> _exceptionProcessResultGitPush(ProcessResult processResult) async {
    processResult.print();
    return Future.error(
      PushException(
        getCommitExceptionTextGitPush(_releaseNote),
      ),
    );
  }
}
