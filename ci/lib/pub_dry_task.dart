import 'package:ci/domain/element.dart';
import 'package:ci/runner/shell_runner.dart';

import 'exceptions/exceptions.dart';

class DryRunTask {
  Future<void> run(List<Element> elements) async {
    var messages = [];
    for (var element in elements) {
      if (element.hosted) {
        var result = await sh('pub publish --dry-run', path: element.path);
        messages.add(element.name.toString() + ' ' + result.stderr.toString());
      }
    }
    if (messages.isNotEmpty) {
      for (var message in messages) {
        ModuleNotReadyForOpenSours(message);
      }
    }
  }
}
