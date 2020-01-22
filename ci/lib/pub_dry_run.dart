import 'package:ci/domain/element.dart';
import 'package:ci/runner/shell_runner.dart';

class DryRunTask {
  List<String> message = [];

  // ignore: missing_return
  Future<bool> run(List<Element> elements) async {
    for (var element in elements) {
      if (element.hosted) {
        var s = await sh('pub publish --dry-run', path: element.path);
        message.add(element.name.toString() + ' ' + s.stderr.toString());
      }
    }

    //        test.then((onValue) {
//          message.add(onValue.stderr);
//        });
//    if (message.isNotEmpty) {
//      for (var error in message) {
//        ModuleNotReadyForOpenSours(error);
//      }
//    }
  }
}
