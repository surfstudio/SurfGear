import 'package:flutter/material.dart';
import 'package:push/push.dart';

import '../domain/message.dart';
import '../ui/first_screen.dart';

class FirstStrategy extends PushHandleStrategy<Message> {
  FirstStrategy(Message payload) : super(payload);

  @override
  void onTapNotification(NavigatorState navigator) {
    debugPrint('on tap notification');

    navigator.push(
      MaterialPageRoute(
        builder: (context) => FirstScreen(payload),
      ),
    );
  }
}
