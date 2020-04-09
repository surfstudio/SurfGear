import 'dart:io';

import 'package:args/args.dart';
import 'package:init_project/domain/command.dart';
import 'package:init_project/services/utils/print_message_console.dart';
import 'package:path/path.dart' as p;

/// Парсер команд.
class CommandParser {
  final ArgParser _argParser = ArgParser();

  /// Опция для указания дирректории шаблонного проекта.
  static const String _path = 'out';
  static const String _pathAbbr = 'o';

  /// Опция для имени проекта, является обязательным.
  static const String _nameProject = 'name';
  static const String _nameProjectAbbr = 'n';

  /// Флаг для вызова help.
  static const String _helpFlag = 'help';
  static const String _helpAbbr = 'h';

  /// Опция для указания своего пути до репозитория с template.
  static const String _remoteUrl = 'remote';
  static const String _remoteUrlAbbr = 'r';

  /// Опция для указания ветки для зависимостей flutter-standard
  static const String _branch = 'branch';
  static const String _branchAbbr = 'b';

  CommandParser() {
    _init_parser();
  }

  /// Выполняет парсинг переданных аргументов и возвращает команду на исполнение.
  Future<Command> parser(List<String> arguments) async {
    try {
      final parsed = _argParser.parse(arguments);

      return _getCommandByArgs(parsed);
    } catch (e) {
      rethrow;
    }
  }

  /// В данном методе необходимо провести инициализацию
  /// у парсера всевозможных опций.
  void _init_parser() {
    _argParser

      /// Путь до проекта.
      ..addOption(
        CommandParser._path,
        abbr: CommandParser._pathAbbr,
        help: 'Way to the project',
        valueHelp: 'path',
        defaultsTo: p.current,
      )

      /// Имя проекта.
      ..addOption(
        CommandParser._nameProject,
        abbr: CommandParser._nameProjectAbbr,
        help: 'Name project',
        valueHelp: 'nameProject',
      )

      /// Ветка зависимостей.
      ..addOption(
        CommandParser._branch,
        abbr: CommandParser._branchAbbr,
        help: 'Dependency branch',
        valueHelp: 'branch',
        defaultsTo: 'dev',
      )

      /// Путь до репозитория
      ..addOption(
        CommandParser._remoteUrl,
        abbr: CommandParser._remoteUrlAbbr,
        help: 'Path to repository https',
        valueHelp: 'url_https',
      )

      /// Help.
      ..addFlag(CommandParser._helpFlag, abbr: CommandParser._helpAbbr, negatable: false, help: 'Help');
  }

  /// Если опции введены верно, парсим их в [Command], иначе возвращаем help.
  ///
  ///  [sleep] необходим в случаи неправильно введённых комманд/опций/флагов,
  ///  в редких случаях вывод ошибки смешавается с help.
  Future<Command> _getCommandByArgs(ArgResults parsed) async {
    final isShowHelp = parsed[CommandParser._helpFlag] as bool;

    if (isShowHelp) {
      printMessageConsole(_argParser.usage);
      return null;
    }

    if (parsed[CommandParser._nameProject] == null) {
      printMessageConsole(_argParser.usage);
      sleep(Duration(microseconds: 10));
      return Future.error(Exception('Enter project name.'));
    }

    if (parsed[CommandParser._remoteUrl] == null) {
      printMessageConsole(_argParser.usage);
      sleep(Duration(microseconds: 10));
      return Future.error(Exception('Enter the URL of the remote repository.'));
    }

    return Command(
      parsed[CommandParser._nameProject],
      parsed[CommandParser._remoteUrl],
      path: parsed[CommandParser._path],
      branch: parsed[CommandParser._branch],
    );
  }
}
