import 'package:counter/data/counter/storage/shared_prefs.dart';

class CounterRepository {
  final SharedPrefs _sharedPrefs;

  CounterRepository(this._sharedPrefs);

  Future<void> changeCounter(int value) => _sharedPrefs.set(value);

  Future<int> getCounter() => _sharedPrefs.get();
}
