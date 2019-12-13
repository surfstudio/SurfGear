import 'package:bottom_sheet/src/flexible_draggable_scrollable_sheet.dart';
import 'package:flutter/material.dart';

/// Start scrolling
typedef bool ScrollStartCallback(ScrollStartNotification notification);

/// Scrolling
typedef bool ScrollCallback(
    FlexibleDraggableScrollableNotification notification);

/// Scroll finished
typedef bool ScrollEndCallback(ScrollEndNotification notification);

/// Listen drag-notifications
class FlexibleScrollNotifyer extends StatelessWidget {
  final Widget child;

  final ScrollStartCallback scrollStartCallback;
  final ScrollCallback scrollingCallback;
  final ScrollEndCallback scrollEndCallback;

  FlexibleScrollNotifyer({
    this.child,
    this.scrollStartCallback,
    this.scrollingCallback,
    this.scrollEndCallback,
  });

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
