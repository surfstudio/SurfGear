import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/repositories/todos_repository.dart';
import 'package:todos/storage/app_storage.dart';
import 'package:todos/ui/screens/add_edit_screen/add_edit_screen.dart';

class TodoListItemWM extends WidgetModel {
  final TodosRepository _todosRepository;
  final BuildContext _context;
  StreamedState<TodoEntity> todoEntity;
  final todoId;

  TodoListItemWM(
    this._context,
    this.todoId,
  )   : _todosRepository = _context.read<AppStorage>().todosRepository,
        super(WidgetModelDependencies()) {
    todoEntity = StreamedState<TodoEntity>(_todosRepository.getTodo(todoId));
  }

  void changeStatus() {
    final value = todoEntity.value;

    _todosRepository.updateTodo(TodoEntity(
      value.id,
      value.title,
      value.description,
      !value.isCompleted,
    ));
    todoEntity.accept(_todosRepository.getTodo(todoId));
  }

  void editTodo() {
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (context) => AddEditScreen(todoEntity: todoEntity.value),
      ),
    );
  }
}
