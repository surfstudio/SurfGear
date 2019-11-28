import 'package:event_filter/event_filter.dart';
import 'package:event_filter/src/impl/error/error_event.dart';

/// Default strategy of filtering error event
class DefaultErrorFilterStrategy extends EventFilterStrategy<ErrorEvent> {
  ErrorEvent _currentEvent;

  @override
  ErrorEvent filter(ErrorEvent event) {
    if (_currentEvent == null) {
      _updateCurrent(event);

      return event;
    } else {
      var currentError = _currentEvent.data;
      var newError = event.data;

      if (currentError.runtimeType != newError.runtimeType) {
        _updateCurrent(event);

        return event;
      } else {
        return null;
      }
    }
  }

  void _updateCurrent(ErrorEvent event) {
    _currentEvent = event;

    Future.delayed(Duration(seconds: 4)).then((_) {
      if (_currentEvent == event) {
        _currentEvent = null;
      }
    });
  }
}