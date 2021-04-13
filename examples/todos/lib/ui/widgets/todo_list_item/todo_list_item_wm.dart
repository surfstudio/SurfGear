import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/modules/provider.dart';
import 'package:todos/repositories/todos_repository.dart';
import 'package:todos/ui/screens/add_edit_screen/add_edit_screen.dart';

class TodoListItemWM extends WidgetModel {
  TodoListItemWM(
    this._context,
    this.todoId,
  )   : _todosRepository = _context.read<AppProvider>().todosRepository,
        super(const WidgetModelDependencies()) {
    todoEntity = StreamedState<TodoEntity>(_todosRepository.getTodo(todoId));
  }

  final TodosRepository _todosRepository;
  final BuildContext _context;
  StreamedState<TodoEntity>? todoEntity;
  final int todoId;

  void changeStatus() {
    final value = todoEntity!.value;

    _todosRepository.updateTodo(TodoEntity(
      id: value!.id,
      title: value.title,
      description: value.description,
      isCompleted: !value.isCompleted,
    ));

    todoEntity!.accept(_todosRepository.getTodo(todoId));
  }

  void editTodo() {
    Navigator.push(
      _context,
      MaterialPageRoute<AddEditScreen>(
        builder: (context) => AddEditScreen(todoEntity: todoEntity!.value),
      ),
    );
  }
}
