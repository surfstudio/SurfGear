import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

///
///SharedPrefs/NSUserDefaults helper
///todo make universal, di, storage helper
///
class PreferencesHelper {
  Future<Object> get(String key, Object defaultValue) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var result = await sp?.get(key) ?? null;
    print("DEV_INFO get from ${sp.toString()} by key $key | result $result");
    return result ?? defaultValue;
  }

  Future set(String key, dynamic value) async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    if (value.runtimeType == String) {
      await _sp.setString(key, value);
    } else if (value.runtimeType == int) {
      await _sp.setInt(key, value);
    } else if (value.runtimeType == double) {
      await _sp.setDouble(key, value);
    } else if (value.runtimeType == bool) {
      await _sp.setBool(key, value);
    } else {
      throw Exception("Does not support type ${value.runtimeType} yet.");
    }
    print("DEV_INFO set to ${_sp.toString()} by key $key | value $value");
  }
}
