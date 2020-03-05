import 'package:args/args.dart';
import 'package:init_project/domain/command.dart';

class CommandParser {
  final ArgParser _argParser = ArgParser();
  static const String path = 'out';
  static const String nameProject = 'name';
  static const String helpFlag = 'help';
  static const String helpAbbr = 'h';

  CommandParser() {
    _init_parser();
  }

  Future<Command> parser(List<String> arguments) async {
    var parsed = _argParser.parse(arguments);

    ///TODO: Exception заполнить
    if (parsed.rest.isNotEmpty) {
      return Future.error(Exception('parsed.rest.isNotEmpty'));
    }
    return _getCommandByArgs(parsed);
  }

  void _init_parser() {
    _argParser
      ..addOption(CommandParser.path, help: 'Way to the project', valueHelp: 'path')
      ..addOption(CommandParser.nameProject, help: 'Name project', valueHelp: 'nameProject')
      ..addFlag(CommandParser.helpFlag, abbr: CommandParser.helpAbbr, negatable: false, help: 'Help');
  }

  Future<Command> _getCommandByArgs(ArgResults parsed) async {
    var isShowHelp = parsed[CommandParser.helpFlag] as bool;

    if (isShowHelp) {
      print(_argParser.usage);
      return null;
    }

    if (parsed[CommandParser.nameProject] == null) {
      print(_argParser.usage);

      ///TODO: Exception заполнить
      return Future.error(Exception('enter project name'));
    }

    return Command(parsed[CommandParser.nameProject], parsed[CommandParser.path]);
  }
}
