import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

class TemplateComponent implements Component {
  TemplateComponent(BuildContext context) {
    _messageController = MaterialMessageController.from(context);
    _dialogController = DefaultDialogController.from(context);

    _wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        _messageController,
        _dialogController,
      ),
    );
  }

  MaterialMessageController _messageController;
  DefaultDialogController _dialogController;
  WidgetModelDependencies _wmDependencies;
}

TemplateWm createTemplateWm(BuildContext context) {
  final component = TemplateComponent(context);

  return TemplateWm(
    component._wmDependencies,
  );
}
