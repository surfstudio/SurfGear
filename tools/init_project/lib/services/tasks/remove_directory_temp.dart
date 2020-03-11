import 'dart:io';

import 'package:init_project/services/manager/message_console_manager.dart';

/// Удаляет временную директорию, где загружен проект
class RemoveDirectoryTemp {
  final Directory _pathDirectoryTemp;
  final ShowMessageManager _showMessageConsole;

  RemoveDirectoryTemp(this._pathDirectoryTemp, this._showMessageConsole);

  /// TODO: реализовать удаление
  Future<void> remove() async {
    _showMessageConsole.printMessageConsole('тут будем удаем темп');
  }
}
