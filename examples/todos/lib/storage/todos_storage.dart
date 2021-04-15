import 'package:todos/models/filter_type.dart';
import 'package:todos/models/todo_entity.dart';

class TodosStorage {
  TodosStorage()
      : _todos = [],
        _currentFilter = FilterType.all;

  final List<TodoEntity> _todos;
  FilterType _currentFilter;

  List<TodoEntity> get todos => _todos;
  FilterType get currentFilter => _currentFilter;

  void addTodo(String title, String description) {
    final todoEntityId = _todos.isEmpty ? 0 : _todos.last.id + 1;
    _todos.add(TodoEntity(
      id: todoEntityId,
      title: title,
      description: description,
      isCompleted: false,
    ));
  }

  TodoEntity getTodo(int todoId) => _todos.firstWhere((e) => e.id == todoId);

  void removeTodo(TodoEntity todoEntity) {
    _todos.removeWhere((e) => e.id == todoEntity.id);
  }

  // ignore: use_setters_to_change_properties
  void setFilter(FilterType newFilter) {
    _currentFilter = newFilter;
  }

  void updateTodo(TodoEntity todoEntity) {
    final todoPlace =
        _todos.indexOf(_todos.firstWhere((e) => e.id == todoEntity.id));
    _todos[todoPlace] = todoEntity;
  }
}
