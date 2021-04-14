import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/repositories/todos_repository.dart';
import 'package:todos/ui/navigation/navigation.dart';

class TodoListItemWM extends WidgetModel {
  TodoListItemWM(
    this._navigation,
    this._todosRepository,
    this.todoId,
  ) : super(const WidgetModelDependencies()) {
    todoEntity = StreamedState<TodoEntity>(_todosRepository.getTodo(todoId));
  }

  final TodosRepository _todosRepository;
  final Navigation _navigation;
  final int todoId;

  StreamedState<TodoEntity> todoEntity = StreamedState<TodoEntity>();

  void changeStatus() {
    final value = todoEntity.value;

    _todosRepository.updateTodo(TodoEntity(
      id: value!.id,
      title: value.title,
      description: value.description,
      isCompleted: !value.isCompleted,
    ));

    todoEntity.accept(_todosRepository.getTodo(todoId));
  }

  void editTodo() {
    _navigation.showAddEditScreen(todoEntity: todoEntity.value);
  }
}
