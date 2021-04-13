import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/modules/provider.dart';
import 'package:todos/repositories/todos_repository.dart';
import 'package:todos/ui/screens/add_edit_screen/add_edit_screen.dart';

class TodoListScreenWM extends WidgetModel {
  TodoListScreenWM(
    this._context,
  )   : _todosRepository = _context.read<AppProvider>().todosRepository,
        super(const WidgetModelDependencies());

  final TodosRepository _todosRepository;
  final BuildContext _context;

  StreamedState<List<TodoEntity>> get todos => _todosRepository.todosState;

  void addTodo() {
    Navigator.push(
      _context,
      MaterialPageRoute<AddEditScreen>(builder: (context) => AddEditScreen()),
    );
  }

  void removeTodo(TodoEntity todoEntity) {
    _todosRepository.removeTodo(todoEntity);
  }
}
