import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

///
///SharedPreferences/NSUserDefaults helper
///todo make universal, di, storage helper
///
class PreferencesHelper {
  Future<T> get<T>(String key, T defaultValue) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final T result = (sp != null) ? await sp.get(key) as T : null;

    return result ?? defaultValue;
  }

  Future set(String key, value) async {
    final SharedPreferences _sp = await SharedPreferences.getInstance();
    if (value is String) {
      await _sp.setString(key, value);
    } else if (value is int) {
      await _sp.setInt(key, value);
    } else if (value is double) {
      await _sp.setDouble(key, value);
    } else if (value is bool) {
      await _sp.setBool(key, value);
    } else {
      throw Exception('Does not support type ${value.runtimeType} yet.');
    }
  }
}
