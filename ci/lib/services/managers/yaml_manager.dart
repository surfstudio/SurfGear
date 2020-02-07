import 'package:yaml/yaml.dart';
import 'package:yamlicious/yamlicious.dart';

/// Менеджер работы с yaml документами.
class YamlManager {
  /// Парсит документ yaml.
  YamlDocument parseYamlDocument(String content) => loadYamlDocument(content);

  /// Возвращает представление yaml в виде строки для записи в файл.
  String convertToYamlFile(YamlNode node) => toYamlString(node);
}