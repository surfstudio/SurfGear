import 'dart:io';
import 'dart:math';

import 'package:init_project/domain/command.dart';
import 'package:init_project/domain/path_directory.dart';
import 'package:init_project/services/utils/print_message_console.dart';
import 'package:io/io.dart';
import 'package:path/path.dart' as p;
import 'package:plain_optional/plain_optional.dart';
import 'package:pubspec_yaml/pubspec_yaml.dart';

/// Путь до папки с template.
const String _pathPackagesTemplate = 'packages/template';

/// For find files with some extension
const String _fileDart = '.dart';
const String _fileYAML = '.yaml';
const String _fileKT = '.kt';
const String _fileJAVA = '.java';

/// Регулярка для замены на название пароекта.
RegExp _expDependency = RegExp('template');

String _pubspecFile = 'pubspec.yaml';

/// шаблон подстановки bundle при замене строк в файлах
const String _bundlePattern = '%bundleId%';

/// старый bundle
final String _oldAndroidBundle = 'ru.surfstudio.template';

/// путь к исходникам android проекта
final _pathToAndroidSources = 'android/src/main/kotlin';

/// android файла содержашие bundle
const Map<String, Map<String, String>> _androidFiles = {
  'android/app/build.gradle': {
    'applicationId "ru.surfstudio.flutterTemplate"':
        'applicationId "%bundleId%"',
  },
  'android/fastlane/Appfile': {
    'package_name(YOUR_PACKAGE_NAME)': 'package_name(%bundleId%)',
  },
  'android/src/main/AndroidManifest.xml': {
    'package="ru.surfstudio.template"': 'package="%bundleId%"',
  }
};

/// ios файла содержашие bundle
const Map<String, Map<String, String>> _iosFiles = {
  'ios/fastlane/Appfile': {
    '# app_identifier "[[APP_IDENTIFIER]]"': 'app_identifier "%bundleId%"',
  },
  'ios/fastlane/Fastfile': {
    'prod_bundle_id = "YOUR_ID"': 'prod_bundle_id = "%bundleId%"',
    'dev_bundle_id = "YOUR_ID"': 'dev_bundle_id = "%bundleId%.development"',
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

  /// получение нового bundle
  String _getBundleId(Command command) =>
      '${command.organizationId}.${command.nameProject}';

  /// переименование зависимостей
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
  /// Для папки 'test' рекурсивно
  Future<List<File>> _searchFile(PathDirectory pathDirectory) async {
    final List<File> files = [];
    final dirProject = Directory(p.join(pathDirectory.path, 'lib'))
        .listSync(recursive: true, followLinks: false)
          ..addAll(Directory(pathDirectory.path)
              .listSync(recursive: false, followLinks: false))
          ..addAll(Directory(p.join(pathDirectory.path, 'test'))
              .listSync(recursive: true, followLinks: false));

    final fileSystemEntities = await _getFiles(
      dirProject,
      [_fileDart, _fileYAML],
    );

    files.addAll(fileSystemEntities);

    return files;
  }

  /// Ищем файлы для замены имени пакета в исходниках андроида
  Future<List<File>> _searchAndroidSourceFile(
      PathDirectory pathDirectory) async {
    final List<File> files = [];
    final dirProject =
        Directory(p.join(pathDirectory.path, _pathToAndroidSources))
            .listSync(recursive: true, followLinks: false);

    final fileSystemEntities = await _getFiles(
      dirProject,
      [_fileJAVA, _fileKT],
    );

    files.addAll(fileSystemEntities);

    return files;
  }

  /// Из списка файлов возвращает файлы с указанным списком расширений
  Future<List<File>> _getFiles(
    List<FileSystemEntity> dirs,
    List<String> fileTypes,
  ) async {
    final List<File> files = [];
    for (var dir in dirs) {
      String fileName = p.basename(dir.path);
      if (await FileSystemEntity.isFile(dir.path)) {
        if (fileTypes.any((fileType) => fileName.contains(fileType))) {
          files.add(dir as File);
        }
      }
    }
    return files;
  }

  /// получение файла по имени
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

  /// замена в строке шаблона на сначение bundle
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

  /// переименование bundle в файлах проекта
  Future<void> _renameBundleId(
    PathDirectory pathDirectory,
    Command command,
  ) async {
    await _renameAndroidBundleId(pathDirectory, command);
    await _renameIosBundleId(pathDirectory, command);
  }

  /// переименование bundle в файлах проекта android
  Future<void> _renameAndroidBundleId(
    PathDirectory pathDirectory,
    Command command,
  ) async {
    printMessageConsole(
        'Change organization to "${command.organizationId}" in android project...');

    _androidFiles.forEach((fileName, patterns) async {
      final file = await _getFileByName(p.join(pathDirectory.path, fileName));
      if (!file.existsSync()) return;
      await _replaceTextInFile(command, file, patterns);
    });

    await _copyAndroidSourceFiles(pathDirectory, command);
  }

  /// копирование исходников по пути с новым bundle
  Future _copyAndroidSourceFiles(
    PathDirectory pathDirectory,
    Command command,
  ) async {
    final oldPathFolder = p.join(
      pathDirectory.path,
      _pathToAndroidSources,
      p.joinAll(_oldAndroidBundle.split('.')),
    );
    final newPathFolder = p.join(
      pathDirectory.path,
      _pathToAndroidSources,
      p.joinAll(_getBundleId(command).split('.')),
    );
    await copyPath(oldPathFolder, newPathFolder);

    await _removeOldFiles(pathDirectory, command);
    await _renamePackageName(pathDirectory, command);
  }

  /// удаление старых файлов исходников с учетом того,
  /// что новый и старый bundle могут частично пересекаться
  Future _removeOldFiles(
    PathDirectory pathDirectory,
    Command command,
  ) async {
    final oldBundleList = _oldAndroidBundle.split('.');
    final newBundleList = _getBundleId(command).split('.');
    if (oldBundleList.isEmpty || newBundleList.isEmpty) return;

    String oldPathFolder =
        p.join(pathDirectory.path, _pathToAndroidSources, oldBundleList[0]);
    final maxIndex = min(oldBundleList.length, newBundleList.length);
    for (int i = 0; i < maxIndex; i++) {
      if (oldBundleList[i] == newBundleList[i]) {
        if (i < maxIndex) {
          oldPathFolder = p.join(oldPathFolder, oldBundleList[i + 1]);
        }
      }
    }

    await Directory(oldPathFolder).delete(recursive: true);
  }

  /// переименование названия пакета в шапке файлов с исходниками
  Future _renamePackageName(
    PathDirectory pathDirectory,
    Command command,
  ) async {
    final oldText = 'package $_oldAndroidBundle';
    final newText = 'package ${_getBundleId(command)}';
    final files = await _searchAndroidSourceFile(pathDirectory);
    await _replacePackageTextInFile(files, oldText, newText);
    await _searchPubspec(command, files);
  }

  /// Перезаписывем текст в файлах, заменяя название пакета.
  Future<void> _replacePackageTextInFile(
    List<File> files,
    String oldText,
    String newText,
  ) async {
    for (var file in files) {
      try {
        final sourceText = await file.readAsString();
        final outText = sourceText.replaceAll(oldText, newText);
        await file.writeAsString(outText);
      } catch (e) {
        rethrow;
      }
    }
  }

  /// переименование bundle в файлах проекта ios
  Future<void> _renameIosBundleId(
    PathDirectory pathDirectory,
    Command command,
  ) async {
    printMessageConsole(
        'Change organization to "${command.organizationId}" in ios project...');

    _iosFiles.forEach((fileName, patterns) async {
      final file = await _getFileByName(p.join(pathDirectory.path, fileName));
      if (!file.existsSync()) return;
      await _replaceTextInFile(command, file, patterns);
    });
  }
}
