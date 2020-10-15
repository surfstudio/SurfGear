import 'package:ci/domain/dependency.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/yaml_manager.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/pubspec_yaml_extension.dart';
import 'package:ci/utils/string_util.dart';
import 'package:path/path.dart';
import 'package:plain_optional/plain_optional.dart';
import 'package:pubspec_yaml/pubspec_yaml.dart';

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
    var yamlDependencies = yaml.dependencies.toList();
    var elementDependencies = element.dependencies;
    for (var dep in elementDependencies) {
      if (!dep.thirdParty) {
        var packageName = dep.element.name;
        var yamlDep = yamlDependencies.firstWhere(
          (dep) => dep.package() == packageName,
          orElse: () => null,
        );

        // рассматриваем гит сценарий, и сценарий зависимости из pub.dev
        // у нас других тут быть не должно,
        // при необходимости добавить с обработкой ошибок и тд
        GitPackageDependencySpec gitDep;
        HostedPackageDependencySpec hostedDep;

        // Страшный хак конечно, но все только потому что все необходимое
        // запривачено так что не добраться.
        // TODO: В идеале бы сделать на все это свой нормальный парсер
        yamlDep.iswitch(
          sdk: null,
          git: (g) {
            gitDep = g;
          },
          path: null,
          hosted: (h) {
            hostedDep = h;
          },
        );

        PackageDependencySpec updatedYamlDep;

        if (gitDep != null) {
          updatedYamlDep = PackageDependencySpec.git(
            GitPackageDependencySpec(
              package: gitDep.package,
              url: gitDep.url,
              path: gitDep.path,
              ref: Optional((dep as GitDependency).ref),
            ),
          );
        }

        if (hostedDep != null) {
          updatedYamlDep = PackageDependencySpec.hosted(
            HostedPackageDependencySpec(
              package: hostedDep.package,
              url: hostedDep.url,
              version: dep is HostedDependency
                  ? Optional(dep.version)
                  : hostedDep.version,
              name: hostedDep.name,
            ),
          );
        }

        if (updatedYamlDep != null) {
          var updateIndex = yamlDependencies.indexOf(yamlDep);
          yamlDependencies.removeAt(updateIndex);
          yamlDependencies.insert(
            updateIndex,
            updatedYamlDep,
          );
        }
      }
    }

    var updatedCustom = Map<String, dynamic>.from(yaml.customFields);
    var custom = updatedCustom['custom'];
    if (custom != null) {
      custom['is_stable'] = element.isStable;
      custom['unstable_version'] = element.unstableVersion;

      custom['is_plugin'] = element.isPlugin;
      custom['path'] = element.directoryName;
      custom['separate_repo_url'] = element.openSourceInfo?.separateRepoUrl;
      custom['hostUrl'] = element.openSourceInfo?.hostUrl;
    }

    return yaml.change(
      version: element.version,
      dependencies: yamlDependencies,
      customFields: updatedCustom,
    );
  }
}
