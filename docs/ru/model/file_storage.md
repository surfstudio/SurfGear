[Главная](../main.md)

# Работа с файловым хранилищем

Для работы с хранилищем используются классы, реализующие интерфейс [Storage][storage_link]. На текущий момент существует только один [JsonStorage][json_storage_link], который позволяет сохранять объекты в формате Json.

## Пример использования

```dart
StreamController<Counter> _counterController;
 
Storage _storage = JsonStorage("jsonStorageExample");

String _counterKey = "counter";

_storage
        .get(_counterKey)
        .then((json) => json == null ? Counter() : Counter.fromJson(json))
        .then((counter) => _currentValue = counter)
        .then(_counterController.add);
```

[json_storage_link]:../../../packages/surf_storage/lib/impl/json_storage.dart
[storage_link]:../../../packages/surf_storage/lib/base/storage.dart
