import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

class Template extends CoreMwwmWidget {
  Template({
    Key key,
  }) : super(
          key: key,
          widgetModelBuilder: (context) => createTemplateWm(context),
        );

  @override
  State<StatefulWidget> createState() => _TemplateState();
}

class _TemplateState extends WidgetState<TemplateWm> {
  
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("TODO"));
  }
}
