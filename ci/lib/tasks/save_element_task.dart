import 'package:ci/domain/config.dart';
import 'package:ci/domain/dependency.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/yaml_manager.dart';
import 'package:ci/services/pubspec_parser.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/pubspec_yaml_extension.dart';
import 'package:path/path.dart';
import 'package:plain_optional/plain_optional.dart';
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
    var str = _yamlManager.convertToYamlFile(yaml);
    var a = 1;
//    _fileSystemManager.writeToFileAsString(
//      filePath,
//      _yamlManager.convertToYamlFile(yaml),
//    );
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
    var yamlDependencies = yaml.dependencies.toList();
    var elementDependencies = element.dependencies;
    for (var dep in elementDependencies) {
      if (!dep.thirdParty) {
        // Какая то обработка
        var packageName = dep.element.name;
        var yamlDep = yamlDependencies.firstWhere(
          (dep) => dep.package() == packageName,
          orElse: () => null,
        );

        // рассматриваем только гит сценарий, у нас других тут быть не должно,
        // при необходимости добавить с обработкой ошибок и тд

        GitPackageDependencySpec gitDep;

        yamlDep.iswitch(
            sdk: null,
            git: (g) {
              gitDep = g;
            },
            path: null,
            hosted: null);

        var updatedYamlDep = PackageDependencySpec.git(
          GitPackageDependencySpec(
            package: yamlDep.package(),
            url: gitDep.url,
            path: gitDep.path,
            ref: Optional('test0',/*(dep as GitDependency).ref*/),
          ),
        );

        yamlDependencies.insert(
          yamlDependencies.indexOf(yamlDep),
          updatedYamlDep,
        );
      }
    }

    return yaml.change(
      version: element.version,
      dependencies: yamlDependencies,
    );
  }
}
