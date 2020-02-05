import 'package:args/args.dart';
import 'package:ci/domain/command.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/tasks/impl/license/licensing_check.dart';
import 'package:ci/utils/arg_results_extension.dart';
import 'package:ci/utils/string_util.dart';

/// Парсер команд
class CommandParser {
  static const String defaultAllFlag = 'all';
  static const String defaultNameOption = 'name';

  final ArgParser _argParser = ArgParser();

  CommandParser() {
    _initParser();
  }

  /// Выполняет парсинг переданных аргументов и возвращает команду на исполнение.
  Future<Command> parse(List<String> arguments) async {
    var parsed = _argParser.parse(arguments);

    if (parsed.rest.isNotEmpty) {
      return Future.error(
        ParseCommandException(
          getParseCommandExceptionText(
            arguments.join(defaultStringSeparator),
          ),
        ),
      );
    }

    var command = await _getCommandByArgs(parsed);
    if (command == null) {
      return Future.error(
        ParseCommandException(
          getParseCommandExceptionText(
            arguments.join(defaultStringSeparator),
          ),
        ),
      );
    }

    return command;
  }

  /// В данном методе необходимо провести инициализацию
  /// у парсера всевозможных опций.
  void _initParser() {
    _argParser.addCommand(LicensingCheck.commandName)
      ..addFlag(LicensingCheck.allFlag, negatable: false)
      ..addOption(LicensingCheck.nameOption);
  }

  Future<Command> _getCommandByArgs(ArgResults results) async {
    var command = results.command;

    if (command == null) {
      return null;
    }

    switch (command.name) {
      default:
        return Command(command.name, command.getParsed());
    }
  }
}
