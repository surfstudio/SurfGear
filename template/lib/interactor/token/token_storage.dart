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

import 'package:flutter_template/util/const.dart';
import 'package:flutter_template/util/sp_helper.dart';

/// Хранилище токена сессии
class AuthInfoStorage {
  static const KEY_TOKEN = "KEY_TOKEN";
  static const KEY_PIN = "KEY_PIN";

  final PreferencesHelper _preferencesHelper;
  String _token;

  AuthInfoStorage(this._preferencesHelper);

  Future<String> getAccessToken() async {
    _token = await _preferencesHelper
        .get(KEY_TOKEN, EMPTY_STRING)
        .then((s) => s as String);
    return _token;
  }

  Future<String> getPin() async {
    String pin = await _preferencesHelper
        .get(KEY_PIN, EMPTY_STRING)
        .then((s) => s as String);
    return pin;
  }

  Future saveToken(String token) async {
    return await _preferencesHelper.set(KEY_TOKEN, token);
  }

  Future savePin(String pin) async {
    return await _preferencesHelper.set(KEY_PIN, pin);
  }

  void clearData() {
    _preferencesHelper.set(KEY_TOKEN, EMPTY_STRING);
    _preferencesHelper.set(KEY_PIN, EMPTY_STRING);
  }
}
