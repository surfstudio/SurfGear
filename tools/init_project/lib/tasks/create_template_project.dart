import 'dart:io';

import 'package:init_project/domain/command.dart';
import 'package:init_project/domain/path_directory.dart';
import 'package:init_project/services/utils/print_message_console.dart';
import 'package:io/io.dart';
import 'package:path/path.dart' as p;
import 'package:plain_optional/plain_optional.dart';
import 'package:pubspec_yaml/pubspec_yaml.dart';

/// Путь до папки с template.
const String _pathPackagesTemplate = 'packages/template';

/// Для поиска файлов *.dart.
const String _fileDart = '.dart';

/// Для поиска файлов *.yaml
const String _fileYAML = '.yaml';

/// Регулярка для замены на название пароекта.
RegExp _expDependency = RegExp('template');

String _pubspecFile = 'pubspec.yaml';

const String _bundlePattern = '%bundleId%';

/// android files containing application id
const Map<String, Map<String, String>> _androidFiles = {
  '/android/app/build.gradle': {
    'applicationId "ru.surfstudio.flutterTemplate"':
        'applicationId "%bundleId%"',
  },
};

/// Создает шаблонный проект.
class CreateTemplateProject {
  Future<void> run(
    Command command,
    PathDirectory pathDirectory,
  ) async {
    try {
      printMessageConsole('Prepare project "${command.nameProject}"...');

      await _copyTemplateInFolder(pathDirectory);
      await _renameDependencies(pathDirectory, command);
      await _renameBundleId(pathDirectory, command);
    } catch (e) {
      rethrow;
    }
  }

  String _getBundleId(Command command) =>
      '${command.organizationId}.${command.nameProject}';

  Future<void> _renameDependencies(
    PathDirectory pathDirectory,
    Command command,
  ) async {
    final files = await _searchFile(pathDirectory);
    await _replaceDependencyTextInFile(command, files);
    await _searchPubspec(command, files);
  }

  /// Копируем template.
  Future<void> _copyTemplateInFolder(PathDirectory pathDirectory) async {
    final pathFolder = p.join(pathDirectory.pathTemp, _pathPackagesTemplate);
    await copyPath(pathFolder, pathDirectory.path);
  }

  /// Ищем файлы для замены template на имя проекта.
  ///
  /// Для папки 'lib' рекурсивно и отдельно в коневой, для поиска '.yaml'
  Future<List<File>> _searchFile(PathDirectory pathDirectory) async {
    final List<File> files = [];
    final dirProject = Directory(p.join(pathDirectory.path, 'lib'))
        .listSync(recursive: true, followLinks: false)
          ..addAll(Directory(pathDirectory.path)
              .listSync(recursive: false, followLinks: false));

    final fileSystemEntities = await _getFiles(dirProject);

    files.addAll(fileSystemEntities);

    return files;
  }

  /// Из списка файлов возвращает файлы .dart и .yaml.
  Future<List<File>> _getFiles(List<FileSystemEntity> dirs) async {
    final List<File> files = [];
    for (var dir in dirs) {
      String fileName = p.basename(dir.path);
      if (await FileSystemEntity.isFile(dir.path)) {
        if (fileName.contains(_fileDart) || fileName.contains(_fileYAML)) {
          files.add(dir as File);
        }
      }
    }
    return files;
  }

  Future<File> _getFileByName(String fileName) async {
    return File(fileName);
  }

  /// Перезаписывем текст в файлах, заменяя зависимости.
  Future<void> _replaceDependencyTextInFile(
    Command command,
    List<File> files,
  ) async {
    for (var file in files) {
      try {
        final sourceText = await file.readAsString();
        final outText =
            sourceText.replaceAll(_expDependency, command.nameProject);
        await file.writeAsString(outText);
      } catch (e) {
        rethrow;
      }
    }
  }

  /// Перезаписывем текст в файлах.
  Future<void> _replaceTextInFile(
    Command command,
    File file,
    Map<String, String> patterns,
  ) async {
    try {
      final sourceText = await file.readAsString();
      var outText = sourceText;
      patterns.forEach((fromPattern, toPattern) {
        outText = outText.replaceAll(
          fromPattern,
          _resolvePattern(command, toPattern),
        );
      });
      await file.writeAsString(outText);
    } catch (e) {
      rethrow;
    }
  }

  String _resolvePattern(Command command, String pattern) {
    return pattern.replaceAll(_bundlePattern, _getBundleId(command));
  }

  /// Ищем pubspec.yaml
  Future<void> _searchPubspec(Command command, List<File> files) async {
    try {
      for (var file in files) {
        final nameFile = p.basename(file.path);
        if (nameFile == _pubspecFile) {
          await _replacePubspec(command, file);
          break;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Перезаписываем pubspec.yaml файл
  Future<void> _replacePubspec(Command command, File file) async {
    try {
      final pubspecYaml =
          PubspecYaml.loadFromYamlString(file.readAsStringSync());

      var replacePubspec = pubspecYaml.copyWith(
          version: Optional('0.0.1+1'),
          dependencies:
              _replaceDependencies(command, pubspecYaml.dependencies.toList()));

      await file.writeAsStringSync(replacePubspec.toYamlString());
    } catch (e) {
      rethrow;
    }
  }

  /// Если [PathPackageDependencySpec] не null, то заменяем на гитовую зависисмость
  Iterable<PackageDependencySpec> _replaceDependencies(
      Command command, List<PackageDependencySpec> dependencies) {
    for (var i = 0; dependencies.length > i; ++i) {
      var path = dependencies[i].dump(_getPathPackageDependencySpec);
      if (path != null) {
        dependencies[i] = PackageDependencySpec.git(
          GitPackageDependencySpec(
            package: path.package,
            url: command.remoteUrl,
            ref: Optional(command.branch),
            path: Optional(p.join('packages', path.package)),
          ),
        );
      }
    }

    return dependencies;
  }

  /// [PathPackageDependencySpec] содержит зависимости для замены
  PathPackageDependencySpec _getPathPackageDependencySpec({
    GitPackageDependencySpec git,
    HostedPackageDependencySpec hosted,
    PathPackageDependencySpec path,
    SdkPackageDependencySpec sdk,
  }) {
    return path;
  }

  Future<void> _renameBundleId(
    PathDirectory pathDirectory,
    Command command,
  ) async {
    await _renameAndroidBundleId(pathDirectory, command);
    await _renameIosBundleId(command);
  }

  Future<void> _renameAndroidBundleId(
    PathDirectory pathDirectory,
    Command command,
  ) async {
    printMessageConsole(
        'Change organization to "${command.organizationId}" in android project...');

    _androidFiles.forEach((fileName, patterns) async {
      final file = await _getFileByName(pathDirectory.path + fileName);
      if (!file.existsSync()) return;
      await _replaceTextInFile(command, file, patterns);
    });
  }

  Future<void> _renameIosBundleId(Command command) async {
    printMessageConsole(
        'Change organization to "${command.organizationId}" in ios project...');
  }
}
