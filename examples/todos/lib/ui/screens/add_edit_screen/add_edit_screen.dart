import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/modules/provider.dart';
import 'package:todos/ui/navigation/navigation.dart';
import 'package:todos/ui/screens/add_edit_screen/add_edit_i18n.dart';
import 'package:todos/ui/screens/add_edit_screen/add_edit_screen_wm.dart';

class AddEditScreen extends CoreMwwmWidget {
  AddEditScreen({
    Key? key,
    TodoEntity? todoEntity,
  }) : super(
            key: key,
            widgetModelBuilder: (context) => AddEditScreenWM(
                  Navigation(context),
                  context.read<AppProvider>().todosRepository,
                  todoEntity,
                ));

  @override
  State<StatefulWidget> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends WidgetState<AddEditScreenWM> {
  String? _title;
  String? _description;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isEditing = wm.isEditing;
    final todoEntity = wm.todoEntity;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? AddEditI18n.editTodo : AddEditI18n.addTodo,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                autofocus: !isEditing,
                initialValue: isEditing ? todoEntity!.title : '',
                style: textTheme.headline5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AddEditI18n.todoTitleLabel,
                ),
                validator: (val) {
                  return val!.trim().isEmpty ? AddEditI18n.emptyTitleWarning : null;
                },
                onSaved: (value) => _title = value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                initialValue: isEditing ? todoEntity!.description : '',
                maxLines: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AddEditI18n.todoDescriptionLabel,
                ),
                style: textTheme.bodyText2,
                onSaved: (value) => _description = value,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _formKey.currentState!.save();
          wm.save(
            _title!,
            _description!,
            isValid: _formKey.currentState!.validate(),
          );
        },
        child: Icon(isEditing ? Icons.check : Icons.add),
      ),
    );
  }
}
