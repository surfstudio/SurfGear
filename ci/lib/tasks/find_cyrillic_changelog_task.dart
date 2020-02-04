import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:path/path.dart';

/// Кириллица
const String _cyrillic = r'[А-ЯЁ]';

/// Файл, который проверяем
const String _nameFile = 'CHANGELOG.md';

/// Поиск кириллицы в файле CHANGELOG.md
class FindCyrillicChangelogTask extends Check {
  final Element element;

  /// Кириллица, без учёта регистра
  final RegExp _regExp = RegExp(_cyrillic, caseSensitive: false);

  /// Менеджер работы с файловой системой.
  final FileSystemManager _fileSystemManager;

  FindCyrillicChangelogTask(
      this.element,
      this._fileSystemManager,
      ) : assert(element != null);

  @override
  Future<bool> run() async {
    var strFile = await _fileSystemManager.readFileAsString(join(element.path, _nameFile));
    if (strFile.contains(_regExp)) {
      return Future.error(
        ModuleContainsCyrillicException(
          getContainsCyrillicInChangelogExceptionText(element.path, element.name),
        ),
      );
    }
    return true;
  }
}
