import 'package:event_filter/event_filter.dart';

/// Event with exception.
class ErrorEvent extends Event<Exception> {
  ErrorEvent(Exception data) : super(data);
}