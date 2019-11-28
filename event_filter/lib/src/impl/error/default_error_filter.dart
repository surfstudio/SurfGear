import 'package:event_filter/event_filter.dart';
import 'package:event_filter/src/factory/event_filter_strategy_factory.dart';

/// Default filter of error events.
class DefaultErrorFilter extends EventFilter {
  DefaultErrorFilter(EventFilterStrategyFactory factory) : super(factory);
}
