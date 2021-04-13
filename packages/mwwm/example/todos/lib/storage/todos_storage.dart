import 'package:todos/models/filter_type.dart';
import 'package:todos/models/todo_entity.dart';

class TodosStorage {
  final List<TodoEntity> _todos;
  FilterType _currentFilter;

  Iterable<TodoEntity> get todos => _todos;
  FilterType get currentFilter => _currentFilter;

  TodosStorage()
      : _todos = [],
        _currentFilter = FilterType.all;

  void addTodo(String title, String description) {
    final todoEntityId = _todos.isEmpty ? 0 : _todos.last.id + 1;
    _todos.add(TodoEntity(todoEntityId, title, description, false));
  }

  TodoEntity getTodo(int todoId) => _todos.firstWhere((e) => e.id == todoId, orElse: () => null);

  void removeTodo(TodoEntity todoEntity) {
    _todos.removeWhere((e) => e.id == todoEntity.id);
  }

  void setFilter(FilterType newFilter) {
    _currentFilter = newFilter;
  }

  void updateTodo(TodoEntity todoEntity) {
    var todoPlace =
        _todos.indexOf(_todos.firstWhere((e) => e.id == todoEntity.id, orElse: () => null));

    if (todoPlace != -1) {
      _todos[todoPlace] = todoEntity;
    } else {
      throw ('TODO id no found');
    }
  }
}
