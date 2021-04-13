import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/modules/provider.dart';
import 'package:todos/repositories/todos_repository.dart';

class AddEditScreenWM extends WidgetModel {
  final GlobalKey<FormState> formKey;

  final TodosRepository _todosRepository;
  final TodoEntity todoEntity;
  final BuildContext context;

  AddEditScreenWM(
    this.context,
    this.todoEntity,
    this.formKey,
  )   : _todosRepository = context.read<AppProvider>().todosRepository,
        super(WidgetModelDependencies());

  bool get isEditing => todoEntity != null;

  void save(String title, String description) {
    if (formKey.currentState.validate()) {
      isEditing ? _editTodo(title, description) : _addTodo(title, description);
      Navigator.pop(context);
    }
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
