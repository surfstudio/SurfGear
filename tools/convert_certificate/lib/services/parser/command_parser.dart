import 'dart:io';

import 'package:args/args.dart';
import 'package:certificate_binarizator/domain/path_certificate.dart';
import 'package:path/path.dart' as path;

/// Command parser.
class CommandParser {
  final ArgParser _argParser = ArgParser();

  /// Option to specify the certificate name.
  static const String _name = 'name';
  static const String _nameAbbr = 'n';

  /// Option for specifying the certificate directorate.
  static const String _inputPath = 'input';
  static const String _inputPathAbbr = 'i';

  /// Option to specify the directory of the binary file.
  static const String _outputPath = 'out';
  static const String _outputPathAbbr = 'o';

  /// Flag to call for help.
  static const String _helpFlag = 'help';
  static const String _helpAbbr = 'h';

  CommandParser() {
    _init();
  }

  void _init() {
    _argParser

      /// Certificate file name.
      ..addOption(
        CommandParser._name,
        abbr: CommandParser._nameAbbr,
        help: 'Certificate file name.',
        valueHelp: 'name certificate',
      )

      /// Directory before the certificate.
      ..addOption(
        CommandParser._inputPath,
        abbr: CommandParser._inputPathAbbr,
        help: 'Certificate location path.',
        valueHelp: 'path',
        defaultsTo: path.current,
      )

      /// Binary certificate preservation directory.
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

  /// Performs parsing of passed arguments and returns the command for execution.
  Future<PathCertificate> parser(List<String> arguments) async {
    try {
      final parsed = _argParser.parse(arguments);

      return _getCommandByArgs(parsed);
    } catch (e) {
      rethrow;
    }
  }

  /// If the options are entered correctly, parse them in [Command], otherwise return help.
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

  /// Output the message to the console
  /// [sleep] is necessary in case of incorrectly entered commands/options/flags,
  /// in rare cases the error output is mixed with help.
  void _printMessage() {
    print(_argParser.usage);
    sleep(const Duration(microseconds: 10));
    return;
  }
}
