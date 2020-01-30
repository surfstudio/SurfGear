import 'package:ci/domain/config.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/pubspec_parser.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/process_result_extension.dart';

/// Задача, выполняющая проверку на изменение стабильности модулей в dev.
///
/// В случае если модуль стал стабильным в резульате изменений в dev,
/// выбрасывается ошибка.
///
/// Задача работает по списку, чтобы избежать множественных checkout в git.
class CheckStabilityDev extends Check {
  static const String _previousAlias = 'HEAD~';

  final List<Element> _elements;

  final PubspecParser _pubspecParser;

  CheckStabilityDev(this._elements, this._pubspecParser);

  @override
  Future<bool> run() async {
    var stableWithChange = _elements
        .where((element) => element.isStable && element.changed)
        .toList();

    if (stableWithChange.isNotEmpty) {
      // выполняем проверку только если у нас есть потенциальная проблема

      // для начала запомним название текущей ветки, нам еще сюда возвращаться
      var branch;
      try {
        branch = await _getCurrentBranch();
      } on GitProcessException catch (e) {
        return Future.error(e);
      }

      // переключаемся на предыдущее состояние ветки
      try {
        await _checkout(_previousAlias);
      } on GitProcessException catch (e) {
        return Future.error(e);
      }

      var previousElements = _pubspecParser.parsePubspecs(Config.packagesPath);

      // переключаемся на актуальное состояние ветки
      try {
        await _checkout(branch);
      } on GitProcessException catch (e) {
        // а вот это очень плохо, вообще не понятно что делать, мы получается
        // остаемся в состоянии отдельного HEAD которое совсем не актуально.
        // Хотя такого в принципе быть не должно
        return Future.error(e);
      }

      // проверяем все отфильтрованные модули на смену состояния
      for (var element in stableWithChange) {
        var previous = previousElements.firstWhere(
          (e) => e.name == element.name,
          orElse: () => null,
        );

        if (previous == null || !previous.isStable) {
          return Future.error(
            StabilityDevChangedException(
              getStabilityDevChangedExceptionText(element.name),
            ),
          );
        }
      }
    }

    return true;
  }

  Future<String> _getCurrentBranch() async {
    var res = await sh('git rev-parse --abbrev-ref HEAD');

    res.print();

    if (res.exitCode != 0) {
      return Future.error(
        CommitHashException(
          getCommitHashExceptionText(res.stderr),
        ),
      );
    }

    return res.stdout.toString();
  }

  Future<void> _checkout(String target) async {
    var res = await sh('git checkout $target');

    res.print();

    if (res.exitCode != 0) {
      return Future.error(
        CheckoutException(
          getCheckoutExceptionText(res.stderr),
        ),
      );
    }
  }
}
