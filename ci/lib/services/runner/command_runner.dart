import 'package:ci/domain/command.dart';
import 'package:ci/domain/config.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/impl/license/licensing_check.dart';

/// Утилита для запуска [Command]
class CommandRunner {
  final PubspecParser _pubspecParser;

  CommandRunner(this._pubspecParser);

  /// Запускает команду на выполнение.
  ///
  /// TODO: разбросать бы это все в идеале по задачам, а тут просто вызывать фабрику которая вернет задачу по команде
  /// тем более такая переделка сделает возможным тестирование, а щас этот класс невозможно тестировать
  Future<void> run(Command command) async {
    switch (command.name) {
      case LicensingCheck.commandName:
        await _checkLicense(command.arguments);
        break;

      default:
        return Future.error(
          CommandHandlerNotFoundException(
            getCommandHandlerNotFoundExceptionText(
              command.name,
            ),
          ),
        );
    }
  }

  Future<bool> _checkLicense(Map<String, dynamic> arguments) {
    var elements = _pubspecParser.parsePubspecs(Config.packagesPath);
    return checkLicensing(elements, arguments);
  }
}
