import 'package:mwwm/mwwm.dart';
import 'package:rxdart/rxdart.dart';

class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);
}

extension StreamedStateExtensions<T> on StreamedState<T> {
  Stream<Pair<T, K>> and<K>(StreamedState<K> other) {
    return Rx.combineLatest2<T, K, Pair<T, K>>(
      this.stream,
      other.stream,
      (t, k) => Pair<T, K>(t, k),
    );
  }
}
