import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

///
///SharedPrefs/NSUserDefaults helper
///todo make universal, di, storage helper
///
class PreferencesHelper {
  static final _ph = PreferencesHelper._internal();

  SharedPreferences _sp;

  PreferencesHelper._internal() {
    _init();
  }

  factory PreferencesHelper.getInstance() => _ph;

  _init() async {
    _sp = await SharedPreferences.getInstance();
    print("DEV_INFO init ${_sp.toString()}");
  }

  Future<dynamic> get(String key) async {
    SharedPreferences sp = _sp;
    var result = await sp?.get(key) ?? null;
    print("DEV_INFO get from ${sp.toString()} by key $key | result $result");
    return result;
  }

  set(String key, dynamic value) async {
    print("DEV_INFO set to ${_sp.toString()} by key $key | value $value");
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
  }
}
