import 'package:init_project/domain/command.dart';
import 'package:init_project/services/repository_manager.dart';

class CommandRunner {
  final RepositoryManager _directoryManager;

  CommandRunner(this._directoryManager);

  Future<void> run(Command command) async {
    try {
      await _directoryManager.run(command);
    } catch (e) {
      rethrow;
    }
  }
}
