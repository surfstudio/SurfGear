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
