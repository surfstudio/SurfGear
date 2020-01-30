import 'package:args/args.dart';
import 'package:ci/domain/command.dart';

/// Парсер команд
class CommandParser {
  final ArgParser _argParser = ArgParser();

  CommandParser() {
    initParser();
  }

  Command parse(List<String> arguments) {
    var parsed = _argParser.parse(arguments);
    var args = parsed.arguments;
    var rest = parsed.rest;
  }

  void initParser() {

  }
}