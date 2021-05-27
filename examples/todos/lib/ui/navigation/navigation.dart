import 'package:flutter/material.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/ui/screens/add_edit_screen/add_edit_screen.dart';

class Navigation {
  Navigation(this._context);

  final BuildContext _context;

  void showAddEditScreen({TodoEntity? todoEntity}) {
    Navigator.push(
      _context,
      MaterialPageRoute<AddEditScreen>(
        builder: (_context) => AddEditScreen(
          todoEntity: todoEntity,
        ),
      ),
    );
  }

  void back() {
    Navigator.pop(_context);
  }
}
