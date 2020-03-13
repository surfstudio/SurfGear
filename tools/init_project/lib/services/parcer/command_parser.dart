import 'dart:io';

import 'package:args/args.dart';
import 'package:init_project/domain/command.dart';
import 'package:path/path.dart' as p;

/// Путь до репозитория по умолчанию, ссылка https
const String _remoteUrl = 'https://osipov-e-surf@bitbucket.org/surfstudio/flutter-standard.git';

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

  /// Парсим
  ///
  ///  [sleep] необходим в случаи неправильно введённых комманд/опций/флагов,
  ///  в редких случаях вывод ошибки смешавается с help
  Future<Command> parser(List<String> arguments) async {
    try {
      var parsed = _argParser.parse(arguments);

      return _getCommandByArgs(parsed);
    } catch (e) {
      print(_argParser.usage);
      sleep(Duration(microseconds: 10));
      rethrow;
    }
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
        defaultsTo: _remoteUrl,
      )

      /// Help
      ..addFlag(CommandParser._helpFlag, abbr: CommandParser._helpAbbr, negatable: false, help: 'Help');
  }

  /// Если опции введены верно, парсим их в [Command], иначе возвращаем help
  Future<Command> _getCommandByArgs(ArgResults parsed) async {
    var isShowHelp = parsed[CommandParser._helpFlag] as bool;

    if (isShowHelp) {
      print(_argParser.usage);
      return null;
    }

    if (parsed[CommandParser._nameProject] == null) {
      return Future.error(Exception('Enter project name'));
    }

    return Command(
      parsed[CommandParser._nameProject],
      path: parsed[CommandParser._path],
      remoteUrl: parsed[CommandParser._remote],
      branch: parsed[CommandParser._branch],
    );
  }
}
