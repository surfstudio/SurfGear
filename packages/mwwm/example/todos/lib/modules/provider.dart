import 'package:todos/repositories/todos_repository.dart';
import 'package:todos/storage/todos_storage.dart';

class AppProvider {
  final TodosRepository todosRepository = TodosRepository(TodosStorage());
}
