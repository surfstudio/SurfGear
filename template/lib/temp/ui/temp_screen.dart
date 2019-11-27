import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/temp/ui/di/temp_screen_component.dart';
import 'package:flutter_template/temp/ui/temp_wm.dart';
import 'package:flutter_template/ui/res/colors.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';

/// Экран <todo>
class TempScreen extends MwwmWidget<TempScreenComponent> {
  TempScreen()
      : super(
          dependenciesBuilder: (context) => TempScreenComponent(context),
          widgetStateBuilder: () => _TempScreenState(),
        );
}

class _TempScreenState extends WidgetState<TempWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return _buildScreen(context);
  }

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
      key: Injector.of<TempScreenComponent>(context).component.scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: white,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Text("temp screen"),
    );
  }
}
