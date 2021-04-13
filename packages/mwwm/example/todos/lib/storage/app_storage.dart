import 'package:todos/repositories/todos_repository.dart';
import 'package:todos/storage/todos_storage.dart';

class AppStorage {
  final TodosRepository todosRepository = TodosRepository(TodosStorage());
}
