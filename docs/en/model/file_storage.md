[Main](../main.md)

# Work with file storage

To work with storage, classes are used that implement the [Storage][storage_link] interface. Currently, there is only one [JsonStorage][json_storage_link], which allows you to save objects in Json format.

## Usage example

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
