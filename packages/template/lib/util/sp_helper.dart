// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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

  Future set(String key, Object value) async {
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
