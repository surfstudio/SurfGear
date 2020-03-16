import 'dart:core' as core;
import 'dart:io';

/// Методы расширения для результатов процесса
extension ProcessResultExtension on ProcessResult {
  /// Выводит в консоль результат
  void print() {
    core.print(this.stdout);
    core.print(this.stderr);
  }
}