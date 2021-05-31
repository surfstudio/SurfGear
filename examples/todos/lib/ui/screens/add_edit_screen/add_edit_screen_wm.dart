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

  String title = '';
  String description = '';

  bool get isEditing => todoEntity != null;

  void save({
    required bool isValid,
  }) {
    if (isValid) {
      isEditing ? _editTodo() : _addTodo();
      _navigation.back();
    }
  }

  void _addTodo() {
    _todosRepository.addTodo(title, description);
  }

  void _editTodo() {
    _todosRepository.updateTodo(TodoEntity(
      id: todoEntity!.id,
      title: title,
      description: description,
      isCompleted: todoEntity!.isCompleted,
    ));
  }
}
