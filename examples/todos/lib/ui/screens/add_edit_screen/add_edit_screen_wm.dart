import 'package:mwwm/mwwm.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/repositories/todos_repository.dart';
import 'package:todos/ui/navigation/navigation.dart';

class AddEditScreenWM extends WidgetModel {
  AddEditScreenWM(
    this._navigation,
    this._todosRepository,
    this.todoEntity,
  ) : super(const WidgetModelDependencies());

  final TodosRepository _todosRepository;
  final Navigation _navigation;

  final TodoEntity? todoEntity;

  bool get isEditing => todoEntity != null;

  void save(
    String title,
    String description, {
    required bool isValid,
  }) {
    if (isValid) {
      isEditing ? _editTodo(title, description) : _addTodo(title, description);
      _navigation.back();
    }
  }

  void _addTodo(String title, String description) {
    _todosRepository.addTodo(title, description);
  }

  void _editTodo(String title, String description) {
    _todosRepository.updateTodo(TodoEntity(
      id: todoEntity!.id,
      title: title,
      description: description,
      isCompleted: todoEntity!.isCompleted,
    ));
  }
}
