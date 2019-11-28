import 'package:event_filter/src/event/event.dart';
import 'package:event_filter/src/strategy/base_event_strategy.dart';

/// The strategy of filtering event.
abstract class EventFilterStrategy<E extends Event>
    extends BaseEventStrategy<E> {
  /// Filter for event.
  /// If event has been pass by filter, it must be return, else return null.
  E filter(E event);
}
