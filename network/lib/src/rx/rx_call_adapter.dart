import 'package:network/src/base/call_adapter.dart';
import 'package:rxdart/rxdart.dart';

///Адаптер для перевода сервисного слоя в [rx]
class RxCallAdapter<T> implements CallAdapter<Future<T>, Observable<T>> {
  @override
  Observable<T> adapt(Future<T> call) {
    return Stream.fromFuture(call);
  }
}
