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
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:path_provider/path_provider.dart';

/// Обёртка над храненилищем JSON в файле
///
/// Creates instance of a local storage. Key is used as a filename
class LocalStorage {
  static final Map<String, LocalStorage> _cache = new Map();

  String _filename;
  File _file;
  Map<String, dynamic> _data;

  /// [ValueNotifier] which notifies about errors during storage initialization
  ValueNotifier<Error> onError;

  /// A future indicating if localstorage intance is ready for read/write operations
  Future<bool> ready;

  /// Prevents the file from being accessed more than once
  Future<void> _lock;

  factory LocalStorage(String key) {
    if (_cache.containsKey(key)) {
      return _cache[key];
    } else {
      final instance = LocalStorage._internal(key);
      _cache[key] = instance;

      return instance;
    }
  }

  LocalStorage._internal(String key) {
    _filename = key;
    _data = new Map();
    onError = new ValueNotifier(null);

    ready = new Future<bool>(() async {
      await this._init();
      return true;
    });
  }

  Future<Directory> _getDocumentDir() async {
    if (Platform.isMacOS || Platform.isLinux) {
      return Directory('${Platform.environment['HOME']}/.config');
    } else if (Platform.isWindows) {
      return Directory('${Platform.environment['UserProfile']}\\.config');
    }
    return await getApplicationDocumentsDirectory();
  }

  Future<void> _init() async {
    try {
      final documentDir = await _getDocumentDir();
      final path = documentDir.path;

      _file = File('$path/$_filename.json');

      var exists = _file.existsSync();

      if (exists) {
        final content = await _file.readAsString();

        try {
          _data = json.decode(content);
        } catch (err) {
          onError.value = err;
          _data = {};
          _file.writeAsStringSync('{}');
        }
      } else {
        _file.writeAsStringSync('{}');
        return _init();
      }
    } on Error catch (err) {
      onError.value = err;
    }
  }

  /// Returns a value from storage by key
  dynamic getItem(String key) {
    return _data[key];
  }

  /// Returns all items
  List<dynamic> getItems() {
    return _data.values.toList();
  }

  /// Saves item by key to a storage. Value should be json encodable (`json.encode()` is called under the hood).
  Future<void> setItem(String key, value) async {
    _data[key] = value;

    return _attemptFlush();
  }

  /// Removes item from storage by key
  Future<void> deleteItem(String key) async {
    _data.remove(key);

    return _attemptFlush();
  }

  /// Removes all items from localstorage
  Future<void> clear() {
    _data.clear();
    return _attemptFlush();
  }

  Future<void> _attemptFlush() async {
    if (_lock != null) {
      await _lock;
    }

    // Lock will complete when file has been written
    _lock = _flush();

    return _lock;
  }

  Future<void> _flush() async {
    final serialized = json.encode(_data);
    try {
      await _file.writeAsString(serialized);
    } catch (e) {
      rethrow;
    }
    return;
  }
}
