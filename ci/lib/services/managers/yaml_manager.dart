import 'package:pubspec_yaml/pubspec_yaml.dart';

/// Менеджер работы с yaml документами.
class YamlManager {
  /// Парсит документ yaml.
  PubspecYaml parseYamlDocument(String content) =>
      PubspecYaml.loadFromYamlString(content);

  /// Возвращает представление yaml в виде строки для записи в файл.
  String convertToYamlFile(PubspecYaml yaml) => yaml.toYamlString();
}
