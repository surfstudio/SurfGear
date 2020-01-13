import 'dart:async';

import 'package:mwwm/mwwm.dart';

/// An abstract Performer interface
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

/// Performer for broadcasting messages while changes appears
abstract class Broadcast<R, C extends Change<R>> extends Performer<R, C> {
  final _controller = StreamController<R>.broadcast();
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