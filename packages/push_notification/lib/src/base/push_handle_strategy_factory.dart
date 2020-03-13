import 'dart:io';

import 'package:logger/logger.dart';
import 'package:push_notification/src/base/push_handle_strategy.dart';

/// strategy builder function
typedef StrategyBuilder = PushHandleStrategy Function(
    Map<String, dynamic> payload);

/// Abstract factory for push notification strategies
abstract class PushHandleStrategyFactory {
  /// Action key in data firebase's push
  /// You can customize your format in the factory implementation.
  final String key = "event";

  /// Default strategy, if in the notification is no strategy information
  StrategyBuilder get defaultStrategy;

  /// Override with the necessary matching actions and strategy builder
  Map<String, StrategyBuilder> get map => {};

  /// Returns a strategy from push data
  PushHandleStrategy createByData(Map<String, dynamic> messageData) {
    var builder;
    try {
      if (Platform.isAndroid) {
        builder = map[messageData['data'][key]];
      } else if (Platform.isIOS) {
        builder = map[messageData[key]];
      }
      return builder(messageData);
    } catch (e) {
      Logger.d('$e - cant found $key');
      return defaultStrategy(messageData);
    }
  }
}
