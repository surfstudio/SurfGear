import 'package:event_filter/event_filter.dart';
import 'package:event_filter/src/factory/event_strategy_factory.dart';

/// Default implementation of strategy provider.
class DefaultErrorStrategyProvider extends EventStrategyProvider {
  DefaultErrorStrategyProvider(EventStrategyFactory factory) : super(factory);
}