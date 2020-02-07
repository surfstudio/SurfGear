import 'package:ci/domain/config.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/yaml_manager.dart';
import 'package:ci/services/pubspec_parser.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:path/path.dart';
import 'package:pubspec_yaml/pubspec_yaml.dart';
import 'package:yaml/yaml.dart';
import 'package:yamlicious/yamlicious.dart';

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
    var fileContent = _fileSystemManager.readFileAsString(
      join(
        _element.path,
        PubspecParser.pubspecFilename,
      ),
    );
//    var yaml = _yamlManager.parseYamlDocument(fileContent);
    var yaml = PubspecYaml.loadFromYamlString(fileContent);
//    var map = yaml.contents as YamlMap;
//
//    var modified = Map.from(map);
//    modified['name'] = 'test';
//
//    var ym = YamlMap.wrap(
//      modified,
//      sourceUrl: join(
//        _element.path,
//        PubspecParser.pubspecFilename,
//      ),
//    );

    var string = yaml.toYamlString();
    return null;
  }
}
