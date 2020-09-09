import 'package:ci/domain/element.dart';
import 'package:ci/tasks/impl/building/update_versions_depending_on_module_task.dart';
import 'package:ci/domain/dependency.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

/// Тест для [UpdateVersionsDependingOnModuleTask]
void main() {
  group('UpdateVersionsDependingOnModuleTask test:', () {
    test(
        'If the element in the dependencies does not match the specified version of the library, it updates the version of the element.',
        () async {
      var res = await _prepareTestTask().run();

      final List<Dependency> dependency = [
        createHostedDependency(
          element: createTestElement(version: "0.0.1-dev.2", name: "test2"),
          thirdParty: false,
        ),
      ];

      final List<Element> updateElements = [
        createTestElement(
            version: "0.1", name: "test5", dependencies: dependency),
      ];

      expect(
        res[0].dependencies[0].element.version,
        updateElements[0].dependencies[0].element.version,
      );
    });
  });
}

UpdateVersionsDependingOnModuleTask _prepareTestTask() {
  final List<Element> elements = [
    createTestElement(version: "0.1", name: "test1"),
    createTestElement(version: "0.0.1-dev.2", name: "test2"),
    createTestElement(version: "0.0.2-dev.4", name: "test3"),
  ];

  final List<Dependency> dependency = [
    createHostedDependency(
      element: createTestElement(version: "0.0.1-dev.0", name: "test2"),
      thirdParty: false,
    ),
    createHostedDependency(
      element: createTestElement(version: "0.0.1", name: "test3"),
      thirdParty: false,
    ),
  ];

  final List<Element> updateElements = [
    createTestElement(version: "0.1", name: "test5", dependencies: dependency),
  ];
  return UpdateVersionsDependingOnModuleTask(elements, updateElements);
}
