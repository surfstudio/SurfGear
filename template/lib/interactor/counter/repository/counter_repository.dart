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

import 'package:flutter_template/domain/counter.dart';
import 'package:flutter_template/util/sp_helper.dart';

class CounterRepository {
  static const String KEY_COUNTER = "KEY_COUNTER";

  final PreferencesHelper _preferencesHelper;

  CounterRepository(this._preferencesHelper);

  setCounter(Counter c) {
    if (c == null) return;
    _preferencesHelper.set(KEY_COUNTER, c.count);
  }

  Future<Counter> getCounter() {
    return _preferencesHelper
        .get(KEY_COUNTER, 0)
        .then(
          (i) => Counter(i ?? 0),
        )
        .catchError(
      (e) {
        print("DEV_ERROR ${e.toString()}");
        return Counter(0);
      },
    );
  }
}
