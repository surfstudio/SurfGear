import 'dart:io';

import 'package:push/push.dart';

/// strategy builder function
typedef StrategyBuilder = PushHandleStrategy Function(
    Map<String, dynamic> payload);

/// Abstract factory for push notification strategies
abstract class PushHandleStrategyFactory {
  /// Action key in data firebase's push
  /// You can customize your format in the factory implementation.
  String key = "event";

  /// Override with the necessary matching actions and strategy builder
  Map<String, StrategyBuilder> get map;

  /// Returns a strategy from push data
  PushHandleStrategy createByData(Map<String, dynamic> messageData) {
    var builder;
    if (Platform.isAndroid) {
      builder = map[messageData['data'][key]];
    } else if (Platform.isIOS) {
      builder = map[messageData[key]];
    }
    return builder(messageData);
  }
}
