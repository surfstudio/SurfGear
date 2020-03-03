import 'dart:io';

import 'package:ci/domain/dependency.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:pubspec_parse/pubspec_parse.dart' as lib;
import 'package:yaml/yaml.dart';

/// Парсер pubspec.yaml
class PubspecParser {
  static const pubspecFilename = 'pubspec.yaml';

  static String _getModulesNotFoundMsg(String dirPath) =>
      'Не найдены модули по заданному пути: $dirPath. Необходимо передать путь к папке, в которой находятся пакеты dart.';

  /// Создание [Element] для каждого модуля, расположенного
  /// в `dirPath`. Информация о библиотеке извлекается из pubspec.yaml.
  List<Element> parsePubspecs(String dirPath) {
    final directory = Directory(dirPath);

    final libDirectories = directory.listSync().whereType<Directory>().toList();
    if (libDirectories.isEmpty) {
      throw ModulesNotFoundException(_getModulesNotFoundMsg(dirPath));
    }

    final pubspecFiles = _findPubspecsUri(libDirectories);
    if (pubspecFiles.isEmpty) {
      throw ModulesNotFoundException(_getModulesNotFoundMsg(dirPath));
    }

    return _parseElements(pubspecFiles);
  }

  List<File> _findPubspecsUri(List<Directory> dirs) {
    final pubspecs = <File>[];

    for (var lib in dirs) {
      final pubspecFile = lib.listSync().firstWhere(
            (file) => file.path.contains(pubspecFilename),
            orElse: () => null,
          );

      if (pubspecFile == null) {
        print('${lib.path} не содержит pubspec.yaml, пропуск.');
        continue;
      }

      pubspecs.add(pubspecFile);
    }

    return pubspecs;
  }

  List<Element> _parseElements(List<File> pubspecFiles) {
    var elements = _createElements(pubspecFiles);
    _linkElements(elements, pubspecFiles);

    return elements.values.toList();
  }

  Map<String, Element> _createElements(List<File> pubspecFiles) {
    var elements = <String, Element>{};

    for (var file in pubspecFiles) {
      final pubspec = file.readAsStringSync();

      final pubspecMap = loadYamlDocument(pubspec).contents as YamlMap;
      final custom = pubspecMap['custom'];

      if (custom == null) {
        throw ElementCustomParamsMissedException(
          getElementCustomParamsMissedExceptionText(
            file.path,
          ),
        );
      }

      final separateRepoUrl = custom['separate_repo_url'];
      final hostUrl = custom['host_url'];
      final openSourceInfo = separateRepoUrl == null && hostUrl == null
          ? null
          : OpenSourceInfo(
              separateRepoUrl: separateRepoUrl,
              hostUrl: hostUrl,
            );

      final element = Element(
        name: pubspecMap['name'],
        version: pubspecMap['version'],
        isStable: custom['is_stable'] as bool,
        unstableVersion: custom['unstable_version'] as int,
        isPlugin: custom['is_plugin'] as bool,
        uri: file.parent.absolute.uri,
        openSourceInfo: openSourceInfo,
      );

      elements[element.name] = element;
    }

    return elements;
  }

  void _linkElements(Map<String, Element> elements, List<File> pubspecFiles) {
    final pubspecs = pubspecFiles
        .map((file) => file.readAsStringSync())
        .map((p) => lib.Pubspec.parse(p))
        .toList();

    for (var pubspec in pubspecs) {
      var dependencies = <Dependency>[];

      for (var entry in pubspec.dependencies.entries) {
        final name = entry.key;
        final dependency = entry.value;

        final element = elements[name];
        Dependency elementDependency;

        if (dependency is lib.SdkDependency) continue;

        if (dependency is lib.GitDependency) {
          elementDependency = GitDependency(
            url: dependency.url.toString(),
            path: dependency.path,
            ref: dependency.ref,
            element: element,
            thirdParty: element == null,
          );
        } else if (dependency is lib.PathDependency) {
          elementDependency = PathDependency(
            path: dependency.path,
            element: element,
            thirdParty: element == null,
          );
        } else if (dependency is lib.HostedDependency) {
          elementDependency = HostedDependency(
            version: dependency.version.toString(),
            element: element,
            thirdParty: element == null,
          );
        }

        dependencies.add(elementDependency);
      }

      elements[pubspec.name].dependencies = dependencies;
    }
  }
}
