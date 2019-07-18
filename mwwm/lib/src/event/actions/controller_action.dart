import 'package:flutter/widgets.dart' show ValueNotifier;

import 'package:mwwm/src/event/action.dart';

/// Wrapper on controller
class Controller<T, C extends ValueNotifier<T>> extends Action<T> {
  final C controller;

  Controller(this.controller, void Function(C controller, Controller) onChanged)
      : super() {
    controller.addListener(() {
      onChanged(controller, this);
    });
  }

  @override
  call([T data]) {
    controller.value = data;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
