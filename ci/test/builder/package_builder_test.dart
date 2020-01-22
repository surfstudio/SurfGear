import 'dart:io';

import 'package:ci/builder/package_builder.dart';
import 'package:ci/domain/element.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

void main() {
  test(
    'build succes integration test',
    () async {
      var dir = Directory.current;
      while (!dir.path.endsWith('flutter-standard') &&
          !dir.path.endsWith('flutter-standard' + Platform.pathSeparator)) {
        dir = dir.parent;
      }

      var packagePath = join(dir.path, 'packages', 'mwwm');

      var element = Element(path: packagePath);
      var builder = PackageBuilder();
      var res = await builder.build(element);
      expect(res, true);
    },
    timeout: Timeout(Duration(minutes: 10)),
  );
}
