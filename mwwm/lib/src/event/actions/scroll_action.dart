import 'package:flutter/widgets.dart' show ScrollController;
import 'package:mwwm/src/event/action.dart';

/// Action for scroll
class ScrollOffsetAction extends Action<double> {
  final controller = ScrollController();

  ScrollOffsetAction([void Function(double data) onChanged])
      : super(onChanged) {
    controller.addListener(() {
      accept(controller.offset);
    });
  }

  @override
  dispose() {
    controller.dispose();
    return super.dispose();
  }
}
