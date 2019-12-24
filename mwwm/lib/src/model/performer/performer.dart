import 'dart:async';

import 'package:mwwm/mwwm.dart';

/// An abstract Performer interface
abstract class Performer<C, R> {
  Future<R> perform(C change);
}

/// Performer for broadcasting messages while changes appears
abstract class Broadcast<C extends Change, R> extends Performer<C, R> {
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