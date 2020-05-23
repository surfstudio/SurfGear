import 'dart:async';

import 'package:mwwm/mwwm.dart';

/// Performer handles a specific [Change].
/// It's a key component in the relationship between WidgetModel
/// that requests some data, and the source of these data.
/// R - type of result 
/// C - type of change on which performer triggers
abstract class Performer<R, C extends Change<R>> {
  Performer();

  factory Performer.from(FunctionalPerformer<R, C> _performerFunc) =>
      _Performer(_performerFunc);

  Future<R> perform(C change);
}

typedef FunctionalPerformer<R, C> = Future<R> Function(C);

class _Performer<R, C extends Change<R>> extends Performer<R, C> {
  final FunctionalPerformer<R, C> _performerFunc;

  _Performer(this._performerFunc);

  @override
  Future<R> perform(C change) {
    return _performerFunc(change);
  }
}

/// Broadcast is a [Performer] that allows listening to
/// results of [perform].
/// R - type of result 
/// C - type of change on which performer triggers
abstract class Broadcast<R, C extends Change<R>> extends Performer<R, C> {
  final _controller = StreamController<R>.broadcast();

  /// Stream of results of [perform].
  Stream<R> get broadcast => _controller.stream;

  @override
  Future<R> perform(C change) {
    var result = performInternal(change);
    _addBroadcast(result);
    return result;
  }

  Future<R> performInternal(C change);

  void _addBroadcast(Future<R> result) {
    _controller.addStream(result.asStream());
  }
}
