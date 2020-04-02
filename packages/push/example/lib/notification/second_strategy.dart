import 'package:flutter/material.dart';
import 'package:push/push.dart';
import 'package:push_demo/domain/message.dart';
import 'package:push_demo/ui/second_screen.dart';

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
