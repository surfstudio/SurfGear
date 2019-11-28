import 'package:event_filter/event_filter.dart';
import 'package:event_filter/src/factory/base_strategy_factory.dart';

/// Factory of filtering event strategy.
class EventFilterStrategyFactory
    extends BaseStrategyFactory<EventFilterStrategy> {
  EventFilterStrategyFactory(
      Map<Type, EventFilterStrategy<Event>> strategies,
      EventFilterStrategy<Event> defaultStrategy,
      ) : super(
    strategies,
    defaultStrategy,
  );
}