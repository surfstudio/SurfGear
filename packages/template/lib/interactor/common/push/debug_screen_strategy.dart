import 'package:flutter/material.dart';
import 'package:flutter_template/domain/debug_push_message.dart';
import 'package:flutter_template/ui/screen/debug/debug_route.dart';
import 'package:push_notification/push_notification.dart';

class DebugScreenStrategy extends PushHandleStrategy<DebugPushMessage> {
  DebugScreenStrategy(DebugPushMessage payload) : super(payload);

  @override
  bool ongoing = true;

  @override
  bool playSound = false;

  @override
  void onTapNotification(NavigatorState navigator) =>
      navigator.push(DebugScreenRoute());

  @override
  void onBackgroundProcess(Map<String, dynamic> message) {
    print('notification background process ${message.toString()}');
  }
}
