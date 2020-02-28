import 'package:ci/domain/element.dart';
import 'package:ci/tasks/utils.dart';
import 'package:test/test.dart';

void main() {
  test('get stable modules', () {
    final stableModule1 = Element(isStable: true);
    final stableModule2 = Element(isStable: true);
    final notStableModule1 = Element(isStable: false);
    final notStableModule2 = Element(isStable: false);

    final stableModules = getStableModules([
      stableModule1,
      stableModule2,
      notStableModule1,
      notStableModule2,
    ]);

    expect(stableModules.contains(stableModule1), true);
    expect(stableModules.contains(stableModule2), true);
    expect(stableModules.contains(notStableModule1), false);
    expect(stableModules.contains(notStableModule2), false);
  });
}
