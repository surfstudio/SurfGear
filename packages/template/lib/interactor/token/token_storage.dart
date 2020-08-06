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

import 'package:flutter_template/util/const.dart';
import 'package:flutter_template/util/sp_helper.dart';

/// Хранилище токена сессии
class AuthInfoStorage {
  AuthInfoStorage(this._preferencesHelper);

  static const keyToken = 'KEY_TOKEN';
  static const keyPin = 'KEY_PIN';

  final PreferencesHelper _preferencesHelper;
  String _token;

  Future<String> getAccessToken() async {
    _token = await _preferencesHelper.get(keyToken, emptyString).then((s) => s);
    return _token;
  }

  Future<String> getPin() async {
    final pin =
        await _preferencesHelper.get(keyPin, emptyString).then((s) => s);
    return pin;
  }

  Future saveToken(String token) async {
    return _preferencesHelper.set(keyToken, token);
  }

  Future savePin(String pin) async {
    return _preferencesHelper.set(keyPin, pin);
  }

  void clearData() {
    _preferencesHelper..set(keyToken, emptyString)..set(keyPin, emptyString);
  }
}
