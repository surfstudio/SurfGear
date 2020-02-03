import 'package:args/args.dart';
import 'package:ci/domain/command.dart';

const String _optionAll = 'all';

/// Парсер команд
class CommandParser {
  final ArgParser _argParser = ArgParser();

  CommandParser() {
    _initParser();
  }

  Command parse(List<String> arguments) {
    var parsed = _argParser.parse(arguments);

    return _getCommandByArgs(parsed);
  }

  /// В данном методе необходимо провести инициализацию
  /// у парсера всевозможных опций.
  void _initParser() {
    _argParser.addFlag(_optionAll, negatable: false);
  }

  Command _getCommandByArgs(ArgResults results) {
    var rest = results.rest;
    var command = rest[0];

    switch (command) {
      case ''

      default:
        return null;
    }
  }
}