import 'package:event_filter/event_filter.dart';
import 'package:event_filter/src/factory/event_strategy_factory.dart';
import 'package:flutter/material.dart';

/// Provider of strategy for resolve event.
abstract class EventStrategyProvider {
  @protected
  final EventStrategyFactory factory;

  EventStrategyProvider(this.factory);

  /// Resolve strategy for event.
  void resolve(Event event) {
    var strategy = factory.findStrategy(event);

    strategy.resolve(event);
  }
}