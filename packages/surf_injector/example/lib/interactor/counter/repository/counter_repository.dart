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

import 'package:counter/domain/counter.dart';
import 'package:counter/util/sp_helper.dart';

/// Counter state storage
class CounterRepository {
  CounterRepository(this._preferencesHelper);

  static const String keyCounter = 'KEY_COUNTER';

  final PreferencesHelper _preferencesHelper;

  void setCounter(Counter c) {
    if (c == null) return;
    _preferencesHelper.set(keyCounter, c.count);
  }

  Future<Counter> getCounter() {
    return _preferencesHelper
        .get(keyCounter, 0)
        .then((i) => Counter(i as int ?? 0))
        .catchError(
      // ignore: avoid_annotating_with_dynamic
      (dynamic e) {
        // ignore: avoid_print
        print('DEV_ERROR ${e.toString()}');
        return Counter(0);
      },
    );
  }
}
