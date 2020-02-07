import 'package:ci/domain/config.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/yaml_manager.dart';
import 'package:ci/services/pubspec_parser.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/pubspec_yaml_extension.dart';
import 'package:path/path.dart';
import 'package:pubspec_yaml/pubspec_yaml.dart';

void main() {
  var list = PubspecParser().parsePubspecs(Config.packagesPath);
  var element = list.firstWhere((e) => e.name == 'bottom_navigation_bar');

  SaveElementTask(
    element,
    FileSystemManager(),
    YamlManager(),
  ).run();
}

/// Задача сохранения состояния [Element].
class SaveElementTask extends Action {
  final FileSystemManager _fileSystemManager;
  final YamlManager _yamlManager;
  final Element _element;

  SaveElementTask(
    this._element,
    this._fileSystemManager,
    this._yamlManager,
  );

  @override
  Future<void> run() async {
    var filePath = join(
      _element.path,
      PubspecParser.pubspecFilename,
    );

    var yaml = _getYamlByElement(_element);
    _fileSystemManager.writeToFileAsString(
      filePath,
      _yamlManager.convertToYamlFile(yaml),
    );
  }

  /// Возвращает yaml файл для представления модуля.
  PubspecYaml _getYamlByElement(Element element) {
    var filePath = join(
      _element.path,
      PubspecParser.pubspecFilename,
    );
    var fileContent = _fileSystemManager.readFileAsString(filePath);

    var yaml = _yamlManager.parseYamlDocument(fileContent);

    // заполнение
    List<PackageDependencySpec> dependencies;
    var elementDependencies = element.dependencies;
    for (var dep in elementDependencies) {
      if (!dep.thirdParty) {
        // Какая то обработка
      }
    }

    return yaml.change(
      version: element.version,
      dependencies: dependencies,
    );
  }
}
