import 'dart:io';

import 'package:ci/domain/config.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/generates_release_notes_task.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

import 'core/test_helper.dart';

void main() {
  group(
    'Generate release notes task test:',
    () {
      test(
        'Generate release notes should write correct changelog.',
        () async {
          var fileSystemManager = FileSystemManagerMock();
          var elements = <Element>[
            _testElement(0),
            _testElement(1),
            _testElement(2),
          ];
          _prepareReadValue(fileSystemManager, elements[0]);
          _prepareReadValue(fileSystemManager, elements[1]);
          _prepareReadValue(fileSystemManager, elements[2]);

          var callingMap = <String, dynamic>{
            'git add ../RELEASE_NOTES.md': true,
            "git commit -m 'update RELEASE_NOTES.md file'": true,
            'git push origin master': true,
          };
          substituteShell(callingMap: callingMap);

          var task = GeneratesReleaseNotesTask(elements, fileSystemManager);

          await task.run();

          verify(
            fileSystemManager.writeToFileAsString(
              Config.releaseNoteFilePath,
              _expectChangeLogValue,
              mode: FileMode.write,
            ),
          ).called(1);
        },
      );
    },
  );

  group(
    'Git fail should throw exception tests:',
    () {
      test(
        'add file',
        () async {
          var callingMap = <String, dynamic>{
            'git add ../RELEASE_NOTES.md': false,
          };

          _testGitCommand(
            callingMap,
            throwsA(
              TypeMatcher<GitAddException>(),
            ),
          );
        },
      );

      test(
        'commit file',
        () async {
          var callingMap = <String, dynamic>{
            'git add ../RELEASE_NOTES.md': true,
            "git commit -m 'update RELEASE_NOTES.md file'": false,
          };

          _testGitCommand(
            callingMap,
            throwsA(
              TypeMatcher<CommitException>(),
            ),
          );
        },
      );

      test(
        'push file',
        () async {
          var callingMap = <String, dynamic>{
            'git add ../RELEASE_NOTES.md': true,
            "git commit -m 'update RELEASE_NOTES.md file'": true,
            'git push origin master': false,
          };

          _testGitCommand(
            callingMap,
            throwsA(
              TypeMatcher<PushException>(),
            ),
          );
        },
      );
    },
  );
}

void _prepareReadValue(FileSystemManagerMock mock, Element element) {
  when(
    mock.readFileAsString(
      join(
        element.path,
        'CHANGELOG.md',
      ),
    ),
  ).thenReturn('test value for ${element.name}');
}

Element _testElement(int index) => createTestElement(
      path: 'test$index/path',
      name: 'test$index',
    );
const String _expectChangeLogValue =
    '# test0test value for test0# test1test value for test1# test2test value for test2';

void _testGitCommand(Map<String, dynamic> callingMap, matcher) {
  var fileSystemManager = FileSystemManagerMock();
  var elements = <Element>[
    _testElement(0),
  ];
  _prepareReadValue(fileSystemManager, elements[0]);

  substituteShell(callingMap: callingMap);

  var task = GeneratesReleaseNotesTask(elements, fileSystemManager);
  expect(() async => await task.run(), matcher);
}
