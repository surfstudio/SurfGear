import 'package:init_project/domain/command.dart';
import 'package:init_project/services/directory_manager.dart';

class CommandRunner {
  final DirectoryManager _directoryManager;

  CommandRunner(this._directoryManager);

  Future<void> run(Command command) async {
    try {

		} catch (e) {
      rethrow;
    }
  }
}
