import 'package:ci/domain/element.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';

/// Задача, выполняющая проверку на изменение стабильности модулей в dev.
///
/// В случае если модуль стал стабильным в резульате изменений в dev,
/// выбрасывается ошибка.
///
/// Задача работает по списку, чтобы избежать множественных checkout в git.
class CheckStabilityDev extends Check {
  final List<Element> _elements;

  CheckStabilityDev(this._elements);

  @override
  Future<bool> run() async {
    var stableWithChange = _elements
        .where((element) => element.isStable && element.changed)
        .toList();
    
    if (stableWithChange.isNotEmpty) {
      // выполняем проверку только если у нас есть потенциальная проблема
      
      // для начала запомним хеш коммита, нам еще сюда возвращаться
      var res = await sh('git rev-parse HEAD');

      if (res.exitCode != 0) {
        // TODO: нормальную ошибку
        return Future.error('failed get commit hash');
      }

      var hash = res.stdout.toString();
    }
    
    return true;
  }
}
