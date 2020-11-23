import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// Виджет [Template]
class Template extends MwwmWidget<TemplateComponent> {
  Template({
    Key key,
    WmBuilder WmBuilder = createTemplateWm,
  }) : super(
          key: key,
          WmBuilder: WmBuilder,
          dependenciesBuilder: (context) => TemplateComponent(context),
          widgetStateBuilder: () => _TemplateState(),
        );
}

class _TemplateState extends WidgetState<TemplateWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<TemplateComponent>(context).component.scaffoldKey,
      body: Center(
        child: Text("Template screen"),
      ),
    );
  }
}
