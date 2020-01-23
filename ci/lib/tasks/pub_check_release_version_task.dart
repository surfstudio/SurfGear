import 'package:ci/domain/element.dart';
import 'package:ci/services/pub_publish_manager.dart';
import 'package:ci/tasks/core/task.dart';

class PubCheckReleaseVersionTask extends Check {
  final List<Element> elements;

  PubCheckReleaseVersionTask(this.elements) : assert(elements != null);

  @override
  Future<bool> run() async {
    var changedElements = elements.where((element) => element.changed);
    var processResults = [];
    var str = [];
    for (var element in elements) {
      var processResult = await checkDryRun(element);
      processResults.add(processResult);
    }

    for (var processResult in processResults) {
      if (processResult
          .toString()
          .contains('CHANGELOG.md doesn\'t mention current version')) {

      }
    }

    if (changedElements.isNotEmpty) {
      return false;
    }
    return true;
  }
}
