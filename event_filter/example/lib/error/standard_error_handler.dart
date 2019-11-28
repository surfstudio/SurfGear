import 'package:event_filter/event_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';

/// Standard error handler.
class StandardErrorHandler extends ErrorHandler {
  final EventFilter filter;
  final EventStrategyProvider strategyProvider;

  StandardErrorHandler({
    this.filter,
    @required this.strategyProvider,
  });

  @override
  void handleError(Object e) {
    var event = ErrorEvent(e);

    /// filtering if filter was set
    if (filter != null) {
      event = filter.filter(event);
    }

    if (event != null) {
      strategyProvider.resolve(event);
    }
  }
}
