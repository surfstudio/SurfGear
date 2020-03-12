import 'package:flutter/material.dart';
import 'package:push/push.dart';

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
}
