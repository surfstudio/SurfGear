import 'dart:io';

import 'package:init_project/services/manager/message_console_manager.dart';

/// Создает шаблонный проект
class CreateTemplateProject {
  final Directory _pathDirectoryTemp;
  final ShowMessageManager _showMessageConsole;
  Directory _pathDirectory;

  CreateTemplateProject(
    this._pathDirectoryTemp,
    this._showMessageConsole,
  );

  Future<void> run(Directory _pathDirectory) async {
    _showMessageConsole.printMessageConsole('message');
  }
}
