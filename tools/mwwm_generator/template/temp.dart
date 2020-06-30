import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/ui/res/colors.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';

import 'di/temp_component.dart';
import 'temp_wm.dart';

/// Виджет [$Temp$]
class $Temp$ extends MwwmWidget<$Temp$Component> {
  $Temp$([
    WidgetModelBuilder widgetModelBuilder = create$Temp$WidgetModel,
  ]) : super(
          widgetModelBuilder: widgetModelBuilder,
          dependenciesBuilder: (context) => $Temp$Component(context),
          widgetStateBuilder: () => _$Temp$State(),
        );
}

class _$Temp$State extends WidgetState<$Temp$WidgetModel> {
  @override
  Widget build(BuildContext context) {
    return _buildScreen(context);
  }

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
      key: Injector.of<$Temp$Component>(context).component.scaffoldKey,
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
