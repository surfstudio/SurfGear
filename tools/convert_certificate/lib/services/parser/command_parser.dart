import 'dart:io';

import 'package:args/args.dart';
import 'package:convert_certificate/domain/path_certificate.dart';
import 'package:path/path.dart' as path;

/// Парсер команд.
class CommandParser {
  final ArgParser _argParser = ArgParser();

  /// Опция для указания имени сертификата.
  static const String _name = 'name';
  static const String _nameAbbr = 'n';

  /// Опция для указания дирректории сертификата.
  static const String _inputPath = 'input';
  static const String _inputPathAbbr = 'i';

  /// Опция для указания дирректории бинарного файла.
  static const String _outputPath = 'out';
  static const String _outputPathAbbr = 'o';

  /// Флаг для вызова help.
  static const String _helpFlag = 'help';
  static const String _helpAbbr = 'h';

  CommandParser() {
    _init();
  }

  void _init() {
    _argParser

      /// Дирректория до сертификата.
      ..addOption(
        CommandParser._name,
        abbr: CommandParser._nameAbbr,
        help: 'Certificate file name.',
        valueHelp: 'name certificate',
      )

      /// Дирректория сертификата.
      ..addOption(
        CommandParser._inputPath,
        abbr: CommandParser._inputPathAbbr,
        help: 'Certificate location path.',
        valueHelp: 'path',
        defaultsTo: path.current,
      )

      /// Дирректория сохранения бинарного сертификата
      ..addOption(
        CommandParser._outputPath,
        abbr: CommandParser._outputPathAbbr,
        help: 'Path to the location of the binary certificate.',
        valueHelp: 'path',
        defaultsTo: path.current,
      )

      /// Help.
      ..addFlag(
        CommandParser._helpFlag,
        abbr: CommandParser._helpAbbr,
        negatable: false,
        help: 'Help',
      );
  }

  /// Выполняет парсинг переданных аргументов и возвращает команду на исполнение.
  Future<PathCertificate> parser(List<String> arguments) async {
    try {
      final parsed = _argParser.parse(arguments);

      return _getCommandByArgs(parsed);
    } catch (e) {
      rethrow;
    }
  }

  /// Если опции введены верно, парсим их в [Command], иначе возвращаем help.
  Future<PathCertificate> _getCommandByArgs(ArgResults parsed) async {
    final isShowHelp = parsed[CommandParser._helpFlag] as bool;
    if (isShowHelp) {
      _printMessage();
      return null;
    }

    final inputPath = parsed[CommandParser._inputPath];
    final outputPath = parsed[CommandParser._outputPath];
    final name = parsed[CommandParser._name];
    if (name == null) {
      _printMessage();
      return Future.error(Exception('Enter the name of the certificate.'));
    }

    return PathCertificate(
      inputPath: inputPath,
      outputPath: outputPath,
      name: name,
    );
  }

  /// Выводим ссобщение в консоль
  /// [sleep] необходим в случаи неправильно введённых комманд/опций/флагов,
  /// в редких случаях вывод ошибки смешавается с help.
  void _printMessage() {
    print(_argParser.usage);
    sleep(const Duration(microseconds: 10));
    return;
  }
}
