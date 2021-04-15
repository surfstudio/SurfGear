import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/repositories/todos_repository.dart';
import 'package:todos/ui/navigation/navigation.dart';

class TodoListScreenWM extends WidgetModel {
  TodoListScreenWM(
    this._navigation,
    this._todosRepository,
  ) : super(const WidgetModelDependencies());

  final TodosRepository _todosRepository;
  final Navigation _navigation;

  StreamedState<List<TodoEntity>> get todos => _todosRepository.todosState;

  void addTodo() {
    _navigation.showAddEditScreen();
  }

  void removeTodo(TodoEntity todoEntity) {
    _todosRepository.removeTodo(todoEntity);
  }
}
