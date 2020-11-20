import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// [Component] для Template
class TemplateComponent extends WidgetComponent {
  TemplateComponent(BuildContext context) : super(context) {
    final appComponent = Injector.of<AppComponent>(context).component;
    _navigator = Navigator.of(context);
    _messageController = MaterialMessageController(scaffoldKey);
    _dialogController = DefaultDialogController(scaffoldKey);

    _wmDependencies = WmDependencies(
      errorHandler: StandardErrorHandler(
        _messageController,
        _dialogController
      ),
    );
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  NavigatorState _navigator;
  MessageController _messageController;
  DialogController _dialogController;
  WmDependencies _wmDependencies;
}

/// Билдер для TemplateWm
TemplateWm createTemplateWm(BuildContext context) {
  final component = Injector.of<TemplateComponent>(context).component;
  return TemplateWm(
    component._wmDependencies,
    component._navigator,
  );
}
