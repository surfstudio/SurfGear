import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:path_provider/path_provider.dart';

///
class LocalStorage {
  static final Map<String, LocalStorage> _cache = new Map();

  String _filename;
  File _file;
  Map<String, dynamic> _data;

  ValueNotifier<Error> onError;

  Future<bool> ready;

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

  dynamic getItem(String key) {
    return _data[key];
  }

  List<dynamic> getItems() {
    return _data.values.toList();
  }

  Future<void> setItem(String key, value) async {
    _data[key] = value;

    return _attemptFlush();
  }

  Future<void> deleteItem(String key) async {
    _data.remove(key);

    return _attemptFlush();
  }

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
