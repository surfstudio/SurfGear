import 'package:example/screen/main/di/main_screen_component.dart';
import 'package:example/screen/main/main_wm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

/// Main screen
class MainScreen extends MwwmWidget<MainScreenComponent> {
  MainScreen(
      [WidgetModelBuilder widgetModelBuilder = createMainScreenWidgetModel])
      : super(
          dependenciesBuilder: (context) => MainScreenComponent(context),
          widgetStateBuilder: () => _MainScreenState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _MainScreenState extends WidgetState<MainScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return _buildScreen(context);
  }

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '0',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() {
    wm.nextAction();
  }
}
