import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:cat_facts/data/theme/app_theme.dart';
import 'package:cat_facts/ui/app/app_wm.dart';
import 'package:cat_facts/ui/screen/facts/facts_screen.dart';

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
  Widget build(BuildContext context) {
    return StreamedStateBuilder<AppTheme>(
      streamedState: wm.theme,
      builder: (context, theme) => MaterialApp(
        title: 'Cat Facts',
        theme: ThemeData(primaryColor: Colors.blue),
        darkTheme: ThemeData.dark(),
        themeMode: theme == AppTheme.dark ? ThemeMode.dark : ThemeMode.light,
        home: FactsScreen(),
      ),
    );
  }
}
