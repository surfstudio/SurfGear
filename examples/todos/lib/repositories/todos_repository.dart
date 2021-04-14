import 'package:relation/relation.dart';
import 'package:todos/models/filter_type.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/storage/todos_storage.dart';

class TodosRepository {
  TodosRepository(this._todosStorage)
      : todosState = StreamedState<List<TodoEntity>>(_todosStorage.todos),
        currentFilterState =
            StreamedState<FilterType>(_todosStorage.currentFilter);

  final StreamedState<List<TodoEntity>> todosState;
  final StreamedState<FilterType> currentFilterState;

  final TodosStorage _todosStorage;

  void addTodo(String title, String description) {
    _todosStorage.addTodo(title, description);
    _updateTodosState();
  }

  TodoEntity getTodo(int todoId) => _todosStorage.getTodo(todoId);

  void removeTodo(TodoEntity todoEntity) {
    _todosStorage.removeTodo(todoEntity);
    _updateTodosState();
  }

  void setFilter(FilterType newFilter) {
    _todosStorage.setFilter(newFilter);
    currentFilterState.accept(_todosStorage.currentFilter);
    _updateTodosState();
  }

  void updateTodo(TodoEntity todoEntity) {
    _todosStorage.updateTodo(todoEntity);
    _updateTodosState();
  }

  List<TodoEntity> _filtredTodos() {
    switch (_todosStorage.currentFilter) {
      case FilterType.active:
        return _todosStorage.todos
            .where((element) => !element.isCompleted)
            .toList();
      case FilterType.completed:
        return _todosStorage.todos
            .where((element) => element.isCompleted)
            .toList();
      case FilterType.all:
      default:
        return _todosStorage.todos;
    }
  }

  void _updateTodosState() {
    todosState.accept(_filtredTodos());
  }
}
