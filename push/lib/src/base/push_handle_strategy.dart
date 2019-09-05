import 'package:flutter/cupertino.dart';
import 'package:push/push.dart';

/// abstract notification processing strategy
abstract class PushHandleStrategy<PT extends NotificationPayload> {
  PushHandleStrategy(this.payload);

  /// android chanel setting
  String notificationChannelId = 'default_push_chanel_id';
  String notificationChannelName = 'Chanel name';
  String notificationDescription = 'Chanel description';

  /// push id
  int pushId = 0;

  bool ongoing = false;

  /// notification payload
  final PT payload;

  /// function that is called to process notification clicks
  void onTapNotification(NavigatorState navigator);
}
