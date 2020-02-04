import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/find_cyrillic_changelog_task.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

import 'core/test_helper.dart';

void main() {
  group(
    'Cyrillic search check',
    () {
      test(
        'There is no Cyrillic in the text, it will return true',
        () async {
          var fileSystemManager = FileSystemManagerMock();

          var element = createTestElement();

          _prepareReadValueWithoutCyrillic(
            fileSystemManager,
            element,
            'qwertyuiopasdfghjklzxcvbnm',
          );
          var task = FindCyrillicChangelogTask(element, fileSystemManager);

          expect(
            await task.run(),
            isTrue,
          );
        },
      );

      test(
        'The text has Cyrillic, will return Exception',
        () async {
          var fileSystemManager = FileSystemManagerMock();

          var element = createTestElement();

          _prepareReadValueWithoutCyrillic(
            fileSystemManager,
            element,
            'qwertyuiopasdfghjklzxcvbnmа',
          );
          var task = FindCyrillicChangelogTask(element, fileSystemManager);

          expect(
            () async => await task.run(),
            throwsA(
              TypeMatcher<ModuleContainsCyrillicException>(),
            ),
          );
        },
      );
    },
  );
}

void _prepareReadValueWithoutCyrillic(
  FileSystemManagerMock mock,
  Element element,
  String textInFile,
) {
  when(
    mock.readFileAsString(
      join(element.path, 'CHANGELOG.md'),
    ),
  ).thenReturn(textInFile);
}
