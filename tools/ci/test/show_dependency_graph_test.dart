import 'package:ci/domain/dependency.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/tasks/show_dependency_graph_task.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'core/test_helper.dart';

void main() {
  group(
    'ShowDependencyGraphTask test:',
    () {
      test(
        'Dependencies output to the console must match.',
        () async {
          var elements = _listDependencyTestElement();
          var task = ShowDependencyGraphTask(elements);

          var str = '';
          str += 'test1 ----> | innerDepGit\n';
          str += '            | innerDepGit\n';
          str += '            | innerDepGit\n';
          str += 'test2 ----> | dependency1\n';
          str += '            | innerDepGit ----> | dependency1\n';
          str += '            | innerDepGit ----> | dependency1\n';
          str += '            | innerDepGit ----> | dependency1\n';
          str += 'test3 ----> | dependency2\n';
          str += '            | dependency3\n';
          str += '            | innerDepGit\n';
          str += '            | innerDepGit ----> | dependency2\n';
          str += '            | innerDepGit ----> | dependency2\n';
          str += '                                | dependency3\n\n';
          expect(() async => await task.run(), prints(str));
        },
      );
    },
  );
}

List<Element> _listDependencyTestElement() {
  var elements = <Element>[];
  elements.add(_dependencyTestElement(name: 'test1'));
  elements.add(_dependencyTestElement(name: 'test2', gitBool: false));
  elements.add(_dependencyTestElement(name: 'test3', hostedBool: false, pathBool: false));

  return elements;
}

Element _dependencyTestElement({
  String name,
  bool gitBool = true,
  bool pathBool = true,
  bool hostedBool = true,
  bool gitInnerBool = true,
  bool pathInnerBool = true,
  bool hostedInnerBool = true,
}) {
  var git = GitDependencyMock();
  var path = PathDependencyMock();
  var hosted = HostedDependencyMock();

  var innerDepGit = createGitDependency(
      element: createTestElement(name: 'innerDepGit', dependencies: [git]), thirdParty: false);
  var innerDepPath = createGitDependency(
      element: createTestElement(name: 'innerDepGit', dependencies: [git, path]), thirdParty: false);
  var innerDepHosted = createHostedDependency(
      element: createTestElement(name: 'innerDepGit', dependencies: [git, path, hosted]), thirdParty: false);

  when(git.element).thenReturn(createTestElement(name: 'dependency1'));
  when(path.element).thenReturn(createTestElement(name: 'dependency2'));
  when(hosted.element).thenReturn(createTestElement(name: 'dependency3'));
  when(git.thirdParty).thenReturn(gitBool);
  when(path.thirdParty).thenReturn(pathBool);
  when(hosted.thirdParty).thenReturn(hostedBool);

  var dep = <Dependency>[
    git,
    path,
    hosted,
    innerDepGit,
    innerDepPath,
    innerDepHosted,
  ];
  return createTestElement(
    name: name,
    dependencies: dep,
  );
}
