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

import 'package:localstorage/localstorage.dart';
import 'package:storage/base/storage.dart';

/// Based on [LocalStorage] simple json storage
class JsonStorage implements Storage<String, Map<String, dynamic>> {
  final LocalStorage _storage;

  JsonStorage(String filename)
      : assert(filename != null),
        _storage = LocalStorage(filename);

  @override
  void clear() => _storage.ready.then((_) => _storage.clear());

  @override
  Future<Map<String, dynamic>> get(String key) async {
    await _storage.ready;

    final value = _storage.getItem(key);
    return value != null ? Map<String, dynamic>.from(value) : null;
  }

  @override
  void put(String key, Map<String, dynamic> value) =>
      _storage.ready.then((_) => _storage.setItem(key, value));

  @override
  void remove(String key) =>
      _storage.ready.then((_) => _storage.deleteItem(key));
}
