import 'dart:io';

import 'package:ci/domain/dependency.dart';
import 'package:ci/domain/element.dart';
import 'package:pubspec_parse/pubspec_parse.dart' as lib;
import 'package:yaml/yaml.dart';

const pubspecFilename = 'pubspec.yaml';

/// Создание [Element] для каждого модуля, расположенного
/// в `dirPath`. Информация о библиотеке извлекается из pubspec.yaml.
List<Element> parsePubspecs(String dirPath) {
  final directory = Directory(dirPath);
  final libDirectories = directory.listSync().whereType<Directory>().toList();

  if (libDirectories.isEmpty) {
    throw Exception(
        'Не найдены модули по заданному пути: $dirPath. Необходимо передать путь к папке, в которой находятся пакеты dart.');
  }

  final pubspecs = _findAndReadPubspecs(libDirectories);
  return _parseElements(pubspecs);
}

List<String> _findAndReadPubspecs(List<Directory> dirs) {
  final pubspecs = <String>[];

  for (var lib in dirs) {
    final pubspecFile = lib.listSync().firstWhere(
          (file) => file.path.contains(pubspecFilename),
          orElse: () => null,
        );

    if (pubspecFile == null) {
      print('${lib.path} не содержит pubspec.yaml, пропуск.');
      continue;
    }

    pubspecs.add(File.fromUri(pubspecFile.uri).readAsStringSync());
  }

  return pubspecs;
}

List<Element> _parseElements(List<String> rawPubspecs) {
  final parsedPubspecs = rawPubspecs.map((p) => lib.Pubspec.parse(p)).toList();

  var elements = _createElements(rawPubspecs);
  _linkElements(elements, parsedPubspecs);

  return elements.values.toList();
}

Map<String, Element> _createElements(List<String> pubspecs) {
  var elements = <String, Element>{};

  for (var pubspec in pubspecs) {
    final pubspecMap = loadYamlDocument(pubspec).contents as YamlMap;
    final custom = pubspecMap['custom'];

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
      path: custom['path'],
      openSourceInfo: openSourceInfo,
    );

    elements[element.name] = element;
  }

  return elements;
}

void _linkElements(Map<String, Element> elements, List<lib.Pubspec> pubspecs) {
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
