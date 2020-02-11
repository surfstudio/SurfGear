import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/process_result_extension.dart';

/// Таск сборки библиотеки.
///
/// В случае неудачи PackageBuildException.
class PackageBuilderTask extends Action {
  static const String exampleName = 'example';
  static const String buildCmd = 'flutter build apk';

  final FileSystemManager directoryManager;

  final Element _package;

  PackageBuilderTask(
    this._package,
    this.directoryManager,
  );

  @override
  Future<void> run() async {
    var res = await _build(_package);
    if (res == false) {
      return Future.error(
        PackageBuildException(
          getPackageBuildExceptionText(_package.name),
        ),
      );
    }
  }

  /// Запускает сборку библиотеки.
  ///
  /// В сбору входит:
  /// - сборка примера при наличии
  ///
  /// Возвращает true, в случае успешного билда
  Future<bool> _build(Element package) async {
    return await _buildExample(package);
  }

  Future<bool> _buildExample(Element package) async {
    var list = directoryManager.getEntitiesInDirectory(
      package.uri.path,
      recursive: true,
    );

    var example = list.firstWhere(
      (e) =>
          directoryManager.isDirectory(e.path) &&
          (e.path.endsWith(exampleName) ||
              e.path.endsWith(exampleName + Platform.pathSeparator)),
      orElse: () => null,
    );

    if (example != null) {
      var res = await sh(buildCmd, path: example.path);
      res.print();
      return res.exitCode == 0;
    }

    return true;
  }
}
