import 'package:counter/data/counter/storage/shared_prefs.dart';

class CounterRepository {
  CounterRepository(this._sharedPrefs);

  final SharedPrefs _sharedPrefs;

  Future<void> changeCounter(int value) => _sharedPrefs.set(value);

  Future<int> getCounter() => _sharedPrefs.get();
}
