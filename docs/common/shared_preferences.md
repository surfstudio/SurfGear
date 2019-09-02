# SharedPreferences

[Главная](../main.md)

SharedPreferences — постоянное хранилище на платформе Android и IOS, 
используемое приложениями для хранения своих настроек, ключей, токенов и тд...
Данные храняться в формате key-value.

Для работы с SP используется плагин [shared_preferences](https://pub.dev/packages/shared_preferences)
А так-же студийный хелпер PreferencesHelper, для того чтобы автоматизировать рутинные действия по
созданию и вставке данных в хранилище.

# Пример использования

```dart
class AuthInfoStorage {
  static const KEY_TOKEN = "KEY_TOKEN";
  static const KEY_PIN = "KEY_PIN";

  final PreferencesHelper _preferencesHelper;
  String _token;

  AuthInfoStorage(this._preferencesHelper);

  Future<String> getAccessToken() async {
    _token = await _preferencesHelper
        .get(KEY_TOKEN, EMPTY_STRING)
        .then((s) => s as String);
    return _token;
  }

  Future<String> getPin() async {
    String pin = await _preferencesHelper
        .get(KEY_PIN, EMPTY_STRING)
        .then((s) => s as String);
    return pin;
  }

  Future saveToken(String token) async {
    return await _preferencesHelper.set(KEY_TOKEN, token);
  }

  Future savePin(String pin) async {
    return await _preferencesHelper.set(KEY_PIN, pin);
  }

  void clearData() {
    _preferencesHelper.set(KEY_TOKEN, EMPTY_STRING);
    _preferencesHelper.set(KEY_PIN, EMPTY_STRING);
  }
}
```