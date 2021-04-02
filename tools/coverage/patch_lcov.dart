import 'dart:io';

import 'package:path/path.dart' as p;

const _lcovPath = 'coverage/lcov.info';

void main() {
  final lcovReportFile = File(_lcovPath);
  if (!lcovReportFile.existsSync()) {
    stdout.write('Coverage lcov report does not exist.');

    return;
  }

  final patchedLcov = _getUncoveredFiles(lcovReportFile.readAsLinesSync());

  lcovReportFile.writeAsStringSync(patchedLcov.join('\n'),
      mode: FileMode.writeOnly);
}

const _lcovSourceFileToken = 'SF:';

Iterable<String> _getUncoveredFiles(Iterable<String> lcovContent) =>
    lcovContent.map((content) {
      if (content.startsWith(_lcovSourceFileToken)) {
        final patchedPath = p.relative(
          content.substring(_lcovSourceFileToken.length),
          from: '../../',
        );

        return '$_lcovSourceFileToken$patchedPath';
      }

      return content;
    });
