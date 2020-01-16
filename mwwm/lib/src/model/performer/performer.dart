import 'dart:async';

import 'package:mwwm/mwwm.dart';

/// Performer handles a specific [Change].
/// It's a key component in the relationship between WidgetModel
/// that requests some data, and the source of these data.
abstract class Performer<C, R> {
  Future<R> perform(C change);
}

/// Broadcast is a [Performer] that allows listening to
/// results of [perform].
abstract class Broadcast<C extends Change, R> extends Performer<C, R> {
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