import 'package:ci/domain/element.dart';
import 'package:ci/tasks/core/task.dart';

/// Выполняет проверку лицензии в модуле и копирайтов у файлов.
class LicenseCheck extends Check {
  final Element _package;

  LicenseCheck(
    this._package,
  );

  @override
  Future<bool> run() async {
    return await _check(_package);
  }

  Future<bool> _check(Element package) async {
    return null;
  }
}
