import 'package:flutter/material.dart';
import 'package:push_notification/push_notification.dart';

import '../domain/message.dart';
import '../ui/second_screen.dart';

class SecondStrategy extends PushHandleStrategy<Message> {
  SecondStrategy(Message payload) : super(payload);

  @override
  void onTapNotification(NavigatorState navigator) {
    debugPrint('on tap notification');

    navigator.push(
      MaterialPageRoute(
        builder: (context) => SecondScreen(payload),
      ),
    );
  }

  @override
  void onBackgroundProcess(Map<String, dynamic> message) {
    debugPrint('on process notification in background');
  }
}
