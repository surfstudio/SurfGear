import 'package:event_filter/event_filter.dart';
import 'package:event_filter/src/impl/error/error_event.dart';

/// Default strategy of processing event.
class DefaultErrorStrategy extends EventStrategy<ErrorEvent> {
  @override
  void resolve(ErrorEvent event) {
    print("DEV_ERROR ${event.data}");
  }
}