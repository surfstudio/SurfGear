import 'package:ci/domain/element.dart';
import 'package:ci/pubspec_parser.dart';
import 'package:ci/runner/shell_runner.dart';

class PubDryRun {
  /// Список библиотек
  final String dirPath;

  /// Список представлений [Element]
  List<Element> listElement = [];

  PubDryRun(this.dirPath) {
    listElement.addAll(parsePubspecs(dirPath));

    for (var element in listElement) {
      if (element.hosted) {
        sh(element.path, 'pub publish --dry-run');
      }
    }
  }
}

//bool check(Element element) {
//  return true;
//}
