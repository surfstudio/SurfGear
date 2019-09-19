import 'package:flutter/material.dart';

/// Убирает material glow у списков при прокрутке
class OverscrollGlowAbsorber extends StatelessWidget {
  final Widget child;

  OverscrollGlowAbsorber({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
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
