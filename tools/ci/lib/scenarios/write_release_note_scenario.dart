import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/scenario.dart';

/// Сценарий для команды write_release_note.
///
/// Пример вызова:
/// dart ci write_release_note
class WriteReleaseNoteScenario extends Scenario {
  static const String commandName = 'write_release_note';

  @override
  Map<String, String> getCommandsHelp() => {
        commandName: 'Create a shared RELEASE_NOTES.md and commit it.',
      };

  WriteReleaseNoteScenario(Command command, PubspecParser pubspecParser) : super(command, pubspecParser);

  @override
  Future<void> doExecute(List<Element> elements) async {
    try {
      await writeReleaseNotes(elements);
    } on BaseCiException {
      rethrow;
    }
  }

  @override
  String get getCommandName => commandName;
}
