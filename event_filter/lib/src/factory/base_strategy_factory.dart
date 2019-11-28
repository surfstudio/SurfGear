import 'package:event_filter/event_filter.dart';
import 'package:event_filter/src/event/event.dart';
import 'package:event_filter/src/strategy/base_event_strategy.dart';
import 'package:flutter/material.dart';



abstract class BaseStrategyFactory<T extends BaseEventStrategy> {
  @protected
  final Map<Type, T> strategies;

  @protected
  final T defaultStrategy;

  BaseStrategyFactory(
    this.strategies,
    this.defaultStrategy,
  );

  T findStrategy(Event event) {
    var eventType = event.runtimeType;

    if (strategies.containsKey(eventType)) {
      return strategies[eventType];
    }

    return defaultStrategy;
  }
}
