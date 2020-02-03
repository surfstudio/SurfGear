import 'package:args/args.dart';
import 'package:ci/domain/command.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';

const String _optionAll = 'all';

/// Парсер команд
class CommandParser {
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
            arguments.join(' '),
          ),
        ),
      );
    }

    return _getCommandByArgs(parsed);
  }

  /// В данном методе необходимо провести инициализацию
  /// у парсера всевозможных опций.
  void _initParser() {
    _argParser
        .addCommand('check_licensing')
        .addFlag(_optionAll, negatable: false);
  }

  Future<Command> _getCommandByArgs(ArgResults results) {
   var command = results.command;

    switch (command.name) {
      case 'check_licensing':


      default:
        return null;
    }
  }
}
