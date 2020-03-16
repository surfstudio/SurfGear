import 'package:ci/domain/dependency.dart';
import 'package:ci/domain/tag.dart';
import 'package:ci/tasks/impl/project/update_dependencies_by_tag_task.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

void main() {
  group('Update dependencies by tag task tests:', () {
    test('Should return element changed correct by tag info', () async {
      var testDepName = 'testDependency';
      var element = createTestElement(dependencies: <Dependency>[
        GitDependency(path: testDepName, ref: 'test'),
      ]);

      var tag = ProjectTag('project-test', 1);

      var newElement = await UpdateDependenciesByTagTask(element, tag).run();
      GitDependency dep = newElement.dependencies?.firstWhere(
        (d) => (d is GitDependency) && d.path == testDepName,
        orElse: () => null,
      );

      expect(dep, isNotNull);
      expect(dep.ref, 'project-test-1');
    });

    test('Not GitDependency should not be affected', () async {
      var dep1 = PathDependency();
      var dep2 = HostedDependency();
      var element = createTestElement(dependencies: <Dependency>[
        dep1,
        dep2
      ]);

      var tag = ProjectTag('project-test', 1);

      var newElement = await UpdateDependenciesByTagTask(element, tag).run();

      expect(newElement.dependencies.contains(dep1), isTrue);
      expect(newElement.dependencies.contains(dep2), isTrue);
    });
  });
}
