import 'package:flutter/material.dart';

/// place the [SingleChildScrollView] inside the [DisableOverscroll] widget
/// to prevent glowing when scrolling over the edge
class DisableOverscroll extends StatelessWidget {
  const DisableOverscroll({
    @required this.child,
    Key key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        if (notification is OverscrollIndicatorNotification) {
          notification.disallowGlow();
        }
        return false;
      },
      child: child,
    );
  }
}
