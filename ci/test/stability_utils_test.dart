import 'package:ci/domain/element.dart';
import 'package:ci/stability_utils.dart';
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
}
