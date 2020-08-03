import 'package:bottom_sheet/src/widgets/flexible_draggable_scrollable_sheet.dart';
import 'package:flutter/material.dart';

/// Start scrolling
typedef ScrollStartCallback = bool Function(ScrollStartNotification);

/// Scrolling
typedef ScrollCallback = bool Function(FlexibleDraggableScrollableNotification);

/// Scroll finished
typedef ScrollEndCallback = bool Function(ScrollEndNotification);

/// Listen drag-notifications
class FlexibleScrollNotifyer extends StatelessWidget {
  const FlexibleScrollNotifyer({
    Key key,
    this.child,
    this.scrollStartCallback,
    this.scrollingCallback,
    this.scrollEndCallback,
  }) : super(key: key);

  final Widget child;

  final ScrollStartCallback scrollStartCallback;
  final ScrollCallback scrollingCallback;
  final ScrollEndCallback scrollEndCallback;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollStartNotification>(
      onNotification: scrollStartCallback,
      child: NotificationListener<FlexibleDraggableScrollableNotification>(
        onNotification: scrollingCallback,
        child: NotificationListener<ScrollEndNotification>(
          onNotification: scrollEndCallback,
          child: child,
        ),
      ),
    );
  }
}
