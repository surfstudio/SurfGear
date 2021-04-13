import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:todos/ui/app/app_wm.dart';
import 'package:todos/ui/screens/todo_list_screen/todo_list_screen.dart';

class App extends CoreMwwmWidget {
  App({
    WidgetModelBuilder widgetModelBuilder = createAppWidgetModel,
  }) : super(
          widgetModelBuilder: widgetModelBuilder,
        );

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends WidgetState<AppWidgetModel> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'TODOs',
        theme: ThemeData(primaryColor: Colors.blue),
        darkTheme: ThemeData.dark(),
        home: TodoListScreen(),
      );
}
