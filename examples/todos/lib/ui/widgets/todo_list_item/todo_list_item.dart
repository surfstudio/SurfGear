import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/modules/provider.dart';
import 'package:todos/ui/navigation/navigation.dart';
import 'package:todos/ui/widgets/todo_list_item/todo_list_item_wm.dart';

class TodoListItem extends CoreMwwmWidget {
  TodoListItem({
    required int todoId,
    Key? key,
  }) : super(
          key: key,
          widgetModelBuilder: (context) => TodoListItemWM(
            Navigation(context),
            context.read<AppProvider>().todosRepository,
            todoId,
          ),
        );

  @override
  State<StatefulWidget> createState() => _TodoListItemState();
}

class _TodoListItemState extends WidgetState<TodoListItemWM> {
  @override
  Widget build(BuildContext context) => StreamedStateBuilder<TodoEntity>(
        streamedState: wm.todoEntity,
        builder: (_, todoEntity) => ListTile(
          leading: Checkbox(
            value: todoEntity!.isCompleted,
            onChanged: (_) {
              wm.changeStatus();
            },
          ),
          title: Text(
            todoEntity.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: todoEntity.description.isNotEmpty
              ? Text(
                  todoEntity.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1,
                )
              : null,
          onTap: wm.editTodo,
        ),
      );
}
