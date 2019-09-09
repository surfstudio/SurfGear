/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

///
///SharedPrefs/NSUserDefaults helper
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
