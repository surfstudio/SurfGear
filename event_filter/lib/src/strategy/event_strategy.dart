import 'package:event_filter/src/event/event.dart';
import 'package:event_filter/src/strategy/base_event_strategy.dart';

/// The strategy of event processing.
abstract class EventStrategy<E extends Event> extends BaseEventStrategy<E> {
  /// Resolve event by selected strategy.
  void resolve(E event);
}
