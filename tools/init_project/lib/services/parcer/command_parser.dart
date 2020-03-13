import 'dart:io';

import 'package:args/args.dart';
import 'package:init_project/domain/command.dart';
import 'package:path/path.dart' as p;

/// Путь до репозитория по умолчанию, ссылка https
const String _url = 'https://osipov-e-surf@bitbucket.org/surfstudio/flutter-standard.git';

class CommandParser {
  final ArgParser _argParser = ArgParser();
  static const String _path = 'out';
  static const String _pathAbbr = 'o';
  static const String _nameProject = 'name';
  static const String _nameProjectAbbr = 'n';
  static const String _helpFlag = 'help';
  static const String _helpAbbr = 'h';
  static const String _remote = 'remote';
  static const String _remoteAbbr = 'r';
  static const String _branch = 'branch';
  static const String _branchAbbr = 'b';

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

      /// Путь до проекта
      ..addOption(
        CommandParser._path,
        abbr: CommandParser._pathAbbr,
        help: 'Way to the project',
        valueHelp: 'path',
        defaultsTo: p.current,
      )

      /// Имя проекта
      ..addOption(
        CommandParser._nameProject,
        abbr: CommandParser._nameProjectAbbr,
        help: 'Name project',
        valueHelp: 'nameProject',
      )

      /// Ветка зависимостей
      ..addOption(
        CommandParser._branch,
        abbr: CommandParser._branchAbbr,
        help: 'Dependency branch',
        valueHelp: 'branch',
        defaultsTo: 'dev',
      )

      /// Путь до репозитория
      ..addOption(
        CommandParser._remote,
        abbr: CommandParser._remoteAbbr,
        help: 'Path to repository https',
        valueHelp: 'url',
        defaultsTo: _url,
      )

      /// Help
      ..addFlag(CommandParser._helpFlag, abbr: CommandParser._helpAbbr, negatable: false, help: 'Help');
  }

  /// Если опции введены верно, парсим их в [Command], иначе возвращаем help
  ///
  ///  [sleep] необходим в случаи неправильных введённых опций,
  ///  в редких случаях вывод ошибки смешавается с help
  Future<Command> _getCommandByArgs(ArgResults parsed) async {
    var isShowHelp = parsed[CommandParser._helpFlag] as bool;

    if (isShowHelp) {
      print(_argParser.usage);
      sleep(const Duration(microseconds: 10));
      return null;
    }

    if (parsed[CommandParser._nameProject] == null) {
      print(_argParser.usage);
      sleep(const Duration(microseconds: 10));
      return Future.error(Exception('Enter project name'));
    }

    return Command(
      parsed[CommandParser._nameProject],
      parsed[CommandParser._path],
      parsed[CommandParser._remote],
      parsed[CommandParser._branch],
    );
  }
}
