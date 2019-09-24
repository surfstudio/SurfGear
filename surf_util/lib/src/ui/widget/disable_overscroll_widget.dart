import 'package:flutter/material.dart';

class DisableOverscroll extends StatefulWidget {
  @override
  DisableOverscrollState createState() => new DisableOverscrollState();
}

class DisableOverscrollState extends State<DisableOverscroll> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is OverscrollIndicatorNotification) {
          notification.disallowGlow();
        }
        return false;
      },
    );
  }
}
