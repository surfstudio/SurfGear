import 'package:example/ui/app_component.dart';
import 'package:example/ui/app_wm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends WidgetState<App, AppWidgetModel, AppComponent> {

  @override
  Widget buildState(BuildContext context) {
    TargetPlatform platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS)
      return _buildIosUi(context);
    else
      return _buildAndroidUi(context);
  }

  Widget _buildAndroidUi(BuildContext context) => MaterialApp(
        title: "DataList example",
        home: Scaffold(
          appBar: AppBar(
            title: Text("DataList example"),
          ),
          body: //todo streambuilder
        ),
      );

  Widget _buildIosUi(BuildContext context) => CupertinoApp();

  @override
  AppComponent getComponent(BuildContext context) {
    return AppComponent();
  }
}
