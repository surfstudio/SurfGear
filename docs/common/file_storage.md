# Работа с файловым хранилищем

[Главная](../main.md)

Для работы с хранилищами данных в студийной практике используются расширения класса [Storage](todo link).
Он предоставляет общий публичный апи для работы с данными: get - получить, put - вставить, remove - удалить, 
clear - очистить хранилище.

Для сохранения данных на жесткий диск устройства сейчас имеется класс [LocalStorage](todo link).
Он предоставляет апи для работы с файловой системой исполняемой среды. Данный апи можно оборачивать
в более высокоуровневые классы, которые будут сохранять данные на жесткий диск в различных форматах.

Например, на текущий момент существует обертка [JsonStorage](todo link).
Данный класс является расширением Storage и сохраняет json-объекты на локальный жесткий диск, используя
LocalStorage.

# Пример использования

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