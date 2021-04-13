import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/ui/screens/todo_list_screen/todo_list_screen_i18n.dart';
import 'package:todos/ui/screens/todo_list_screen/todo_list_screen_wm.dart';
import 'package:todos/ui/widgets/filter_button/filter_button.dart';
import 'package:todos/ui/widgets/todo_list_item/todo_list_item.dart';

class TodoListScreen extends CoreMwwmWidget {
  TodoListScreen() : super(widgetModelBuilder: (context) => TodoListScreenWM(context));

  @override
  State<StatefulWidget> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends WidgetState<TodoListScreenWM> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(TodoListScreenI18n.todoListTitle),
          actions: [FilterButton()],
        ),
        body: StreamedStateBuilder<List<TodoEntity>>(
          streamedState: wm.todos,
          builder: (_, todos) => ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return Dismissible(
                key: ValueKey(todo),
                onDismissed: (_) => wm.removeTodo(todo),
                child: TodoListItem(todoId: todo.id),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            wm.addTodo();
          },
          child: Icon(Icons.add),
        ),
      );
}
