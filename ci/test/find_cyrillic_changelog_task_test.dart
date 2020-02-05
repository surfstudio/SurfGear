import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/find_cyrillic_changelog_task.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

import 'core/test_helper.dart';

void main() {
  group(
    'Find cyrillic changelog task test:',
    () {
      test(
        'No cyrillic.',
        () async {
          var task = _prepareTestTask('The quick brown fox jumps over the lazy dog.');
          expect(
            await task.run(),
            isTrue,
          );
        },
      );

      test(
        'There are cyrillic characters throws an exception',
        () async {
          var task = _prepareTestTask(
              'The quick brown fox jumps over the lazy dog. Съешь ещё ж этих мягких французских булок, да выпей чаю');

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

FindCyrillicChangelogTask _prepareTestTask(String textInFile) {
  var mock = FileSystemManagerMock();
  var element = createTestElement();
  when(
    mock.readFileAsString(
      join(element.path, 'CHANGELOG.md'),
    ),
  ).thenReturn(textInFile);

  return FindCyrillicChangelogTask(element, mock);
}
