import 'package:event_filter/src/event/event.dart';
import 'package:event_filter/src/factory/base_strategy_factory.dart';
import 'package:event_filter/src/strategy/event_strategy.dart';

/// Factory of event strategy.
class EventStrategyFactory extends BaseStrategyFactory<EventStrategy> {
  EventStrategyFactory(
      Map<Type, EventStrategy<Event>> strategies,
      EventStrategy<Event> defaultStrategy,
      ) : super(
    strategies,
    defaultStrategy,
  );
}