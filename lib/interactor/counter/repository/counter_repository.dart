import 'package:flutter_template/domain/counter.dart';
import 'package:flutter_template/util/sp_helper.dart';

class CounterRepository {
  static const String KEY_COUNTER = "KEY_COUNTER";

  final PreferencesHelper _preferencesHelper;

  CounterRepository(this._preferencesHelper);

  setCounter(Counter c) {
    _preferencesHelper.set(KEY_COUNTER, c.count);
  }

  Future<Counter> getCounter() {
    return _preferencesHelper.get(KEY_COUNTER).then((d) => d as int)
    .then((i) => Counter(i));
  }
}
