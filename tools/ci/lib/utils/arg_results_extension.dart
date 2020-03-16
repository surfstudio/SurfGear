import 'package:args/args.dart';

/// Методы расширения для аргументов парсинга параметров
extension ArgResultsExtension on ArgResults {
  /// Возвращает список мапу значений опций.
  Map<String, dynamic> getParsed() {
    var res = <String, dynamic>{};
    var options = this.options;
    for (var option in options) {
      res[option] = this[option];
    }

    return res;
  }
}