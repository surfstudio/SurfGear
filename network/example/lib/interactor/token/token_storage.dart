import 'package:name_generator/util/const.dart';
import 'package:name_generator/util/sp_helper.dart';

/// Хранилище токена сессии
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
