import 'package:ci/domain/dependency.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/tasks/impl/building/check_dependency_stable.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Check dependency stable tests:',
    () {
      test(
        'check dependency stable should return false if any dependency unstable',
        () async {
          var stable = Element(isStable: true);
          var unstable = Element(isStable: false);
          var element = Element(
            dependencies: [
              PathDependency(element: stable),
              PathDependency(element: unstable),
            ],
          );

          var check = CheckDependencyStable(element);

          expect(await check.run(), false);
        },
      );

      test(
        'check dependency stable should return true if all dependency stable',
        () async {
          var stable1 = Element(isStable: true);
          var stable2 = Element(isStable: true);
          var stable3 = Element(isStable: true);
          var element = Element(
            dependencies: [
              PathDependency(element: stable1),
              PathDependency(element: stable2),
              PathDependency(element: stable3),
            ],
          );

          var check = CheckDependencyStable(element);

          expect(await check.run(), true);
        },
      );

      test(
        'check dependency stable should not affect not repo dependencies',
        () async {
          var element = Element(
            dependencies: [
              GitDependency(),
            ],
          );

          var check = CheckDependencyStable(element);

          expect(await check.run(), true);
        },
      );
    },
  );
}
