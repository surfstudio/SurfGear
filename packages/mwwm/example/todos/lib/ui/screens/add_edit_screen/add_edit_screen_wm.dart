import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/repositories/todos_repository.dart';
import 'package:todos/storage/app_storage.dart';

class AddEditScreenWM extends WidgetModel {
  final TodosRepository _todosRepository;
  final TodoEntity todoEntity;
  final BuildContext context;

  AddEditScreenWM(
    this.context,
    this.todoEntity,
  )   : _todosRepository = context.read<AppStorage>().todosRepository,
        super(WidgetModelDependencies());

  bool get isEditing => todoEntity != null;

  void save(String title, String description) {
    isEditing ? _editTodo(title, description) : _addTodo(title, description);
    Navigator.pop(context);
  }

  void _addTodo(String title, String description) {
    _todosRepository.addTodo(title, description);
  }

  void _editTodo(String title, String description) {
    _todosRepository.updateTodo(TodoEntity(
      todoEntity.id,
      title,
      description,
      todoEntity.isCompleted,
    ));
  }
}
