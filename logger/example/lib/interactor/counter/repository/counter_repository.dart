import 'package:counter/domain/counter.dart';
import 'package:counter/util/sp_helper.dart';
import 'package:logger/logger.dart';

/// хранилище состояния счетчика
class CounterRepository {
  static const String KEY_COUNTER = "KEY_COUNTER";

  final PreferencesHelper _preferencesHelper;

  CounterRepository(this._preferencesHelper);

  setCounter(Counter c) {
    Logger.d('call CounterRepository.setCounter {counter=${c.count}}');
    if (c == null) return;
    _preferencesHelper.set(KEY_COUNTER, c.count);
  }

  Future<Counter> getCounter() {
    return _preferencesHelper.get(KEY_COUNTER, 0).then(
      (i) {
        Logger.d('call CounterRepository.getCounter {counter=$i}');
        return Counter(i ?? 0);
      },
    ).catchError(
      (e) {
        //print("DEV_ERROR ${e.toString()}");
        Logger.e(e);
        return Counter(0);
      },
    );
  }
}
