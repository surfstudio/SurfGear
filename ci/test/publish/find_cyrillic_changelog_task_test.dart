import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/impl/publish/find_cyrillic_changelog_task.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

/// Тест для [FindCyrillicChangelogTask]
void main() {
  group(
    'Find cyrillic changelog task test:',
    () {
      test(
        'when changelog not contains cyrillic should return true.',
        () async {
          var task =
              _prepareTestTask('The quick brown fox jumps over the lazy dog.');
          expect(
            await task.run(),
            isTrue,
          );
        },
      );

      test(
        'If changelog contains cyrillic, task should throw exception.',
        () async {
          var task = _prepareTestTask(
              'The quick brown fox jumps over the lazy dog. Съешь ещё ж этих мягких французских булок, да выпей чаю');

          expect(
            () async => await task.run(),
            throwsA(
              TypeMatcher<ContainsCyrillicInChangelogException>(),
            ),
          );
        },
      );

      test(
        'If changelog not exist, task should throw correct exception.',
            () async {
          var task = _prepareTestTask(
              '', isExistFile: false);

          expect(
                () async => await task.run(),
            throwsA(
              TypeMatcher<FileNotFoundException>(),
            ),
          );
        },
      );
    },
  );
}

FindCyrillicChangelogTask _prepareTestTask(String textInFile,
    {bool isExistFile = true}) {
  var mock = FileSystemManagerMock();
  var element = createTestElement();
  var filePath = join(element.path, 'CHANGELOG.md');
  when(
    mock.readFileAsString(
      filePath,
    ),
  ).thenReturn(textInFile);
  when(
    mock.isExist(
      filePath,
    ),
  ).thenReturn(isExistFile);

  return FindCyrillicChangelogTask(element, mock);
}
