import 'package:flutter/material.dart';
import 'package:push/push.dart';
import 'package:push_demo/domain/message.dart';
import 'package:push_demo/ui/first_screen.dart';

class FirstStrategy extends BasePushHandleStrategy<Message> {
  @override
  void onTapNotification(NavigatorState navigator) {
    debugPrint('on tap notification');

    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => FirstScreen(payload),
      ),
    );
  }
}
