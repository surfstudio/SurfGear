import 'package:event_filter/src/event/event.dart';
import 'package:event_filter/src/factory/event_filter_strategy_factory.dart';
import 'package:flutter/cupertino.dart';

/// Event filter.
abstract class EventFilter {
  @protected
  final EventFilterStrategyFactory factory;

  EventFilter(this.factory);

  /// Filter event.
  /// If event has been pass by filter, it must be return, else return null.
  Event filter(Event event) {
    var filterStrategy = factory.findStrategy(event);

    return filterStrategy.filter(event);
  }
}
