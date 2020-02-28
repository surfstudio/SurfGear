import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/save_element_task.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart';
import 'package:pubspec_yaml/pubspec_yaml.dart';
import 'package:test/test.dart';

import 'core/test_helper.dart';

void main() {
  group('Save element task tests:', () {
    test(
      'Should call save correct representation of element',
      () async {
        var representation = 'test representation of element';
        var yamlFileContent = 'test yaml file contetnt';
        var element = createTestElement();

        var filePath = join(
          element.path,
          PubspecParser.pubspecFilename,
        );

        var fs = FileSystemManagerMock();
        when(fs.readFileAsString(filePath)).thenReturn(yamlFileContent);
        var ym = YamlManagerMock();
        when(ym.convertToYamlFile(any)).thenReturn(representation);
        when(ym.parseYamlDocument(yamlFileContent)).thenReturn(
          PubspecYaml(name: 'test'),
        );

        var task = SaveElementTask(element, fs, ym);

        await task.run();

        verify(fs.writeToFileAsString(filePath, representation)).called(1);
      },
    );
  });
}
