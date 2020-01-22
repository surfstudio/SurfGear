import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/runner/shell_runner.dart';
import 'package:ci/tasks/checks.dart';
import 'package:test/test.dart';

void main() {
  test('check stable modules for changes', () {
    final stableChanged = Element(
      name: 'stableChanged',
      isStable: true,
      changed: true,
    );

    final notStableChanged = Element(
      name: 'notStableChanged',
      isStable: false,
      changed: true,
    );

    final stableNotChanged = Element(
      name: 'stableNotChanged',
      isStable: true,
      changed: false,
    );

    final notStableNotChanged = Element(
      name: 'notStableNotChanged',
      isStable: false,
      changed: false,
    );

    expect(
      () => checkStableModulesForChanges(
        [
          stableChanged,
          notStableChanged,
          stableNotChanged,
          notStableNotChanged,
        ],
      ),
      throwsException,
    );

    expect(
      () => checkStableModulesForChanges(
        [
          notStableChanged,
          stableNotChanged,
          notStableNotChanged,
        ],
      ),
      returnsNormally,
    );
  });

  test('find changed module', () async {
    final file = File('../packages/auto_reload/lib/auto_reload.dart');
    file.writeAsStringSync(' ', mode: FileMode.append, flush: true);

    await sh('git add ../packages/auto_reload/lib/auto_reload.dart');
    await sh('git commit -m "findchangestest"');

    final element = Element(path: 'auto_reload');
    final changedElements = await findChangedElements([element]);

    expect(changedElements[0] == element, true);

    await sh('git reset HEAD~');
    await sh('git checkout -- ../packages/auto_reload/lib/auto_reload.dart');
  });
}
