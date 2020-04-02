import 'package:flutter/material.dart';
import 'package:push/push.dart';
import 'package:push_demo/domain/message.dart';
import 'package:push_demo/ui/first_screen.dart';

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

  @override
  void onBackgroundProcess(Map<String, dynamic> message) {
    debugPrint('on process notification in background');
  }
}
