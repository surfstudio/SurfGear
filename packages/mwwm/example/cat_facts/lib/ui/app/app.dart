import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';
import 'package:cat_facts/data/theme/app_theme.dart';
import 'package:cat_facts/data/app/app_model.dart';
import 'package:cat_facts/ui/app/app_wm.dart';
import 'package:cat_facts/ui/screen/facts/facts_screen.dart';

class App extends CoreMwwmWidget<AppWidgetModel> {
  App({
    WidgetModelBuilder widgetModelBuilder = createAppWidgetModel,
  }) : super(
          widgetModelBuilder: widgetModelBuilder,
        );

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends WidgetState<AppWidgetModel, App> {
  @override
  Widget build(BuildContext context) {
    return Provider<AppModel>(
      create: (context) => wm.model,
      child: StreamedStateBuilder<AppTheme>(
        streamedState: wm.model.appTheme,
        builder: (context, theme) => MaterialApp(
          title: 'Cat Facts',
          theme: ThemeData(primaryColor: Colors.blue),
          darkTheme: ThemeData.dark(),
          themeMode: theme == AppTheme.dark ? ThemeMode.dark : ThemeMode.light,
          home: FactsScreen(),
        ),
      ),
    );
  }
}
