import 'package:shared_preferences/shared_preferences.dart';

const _counterKey = '_counterKey';

class SharedPrefs {
  Future<void> set(int value) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(_counterKey, value);
  }

  Future<int> get([int defaultValue = 0]) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getInt(_counterKey) ?? defaultValue;
  }
}
