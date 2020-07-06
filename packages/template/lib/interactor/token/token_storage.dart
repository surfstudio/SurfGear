import 'package:flutter_template/util/const.dart';
import 'package:flutter_template/util/sp_helper.dart';

/// Хранилище токена сессии
class AuthInfoStorage {
  static const keyToken = 'KEY_TOKEN';
  static const keyPin = 'KEY_PIN';

  final PreferencesHelper _preferencesHelper;
  String _token;

  AuthInfoStorage(this._preferencesHelper);

  Future<String> getAccessToken() async {
    _token = await _preferencesHelper
        .get(keyToken, emptyString)
        .then((s) => s as String);
    return _token;
  }

  Future<String> getPin() async {
    String pin = await _preferencesHelper
        .get(keyPin, emptyString)
        .then((s) => s as String);
    return pin;
  }

  Future saveToken(String token) async {
    return await _preferencesHelper.set(keyToken, token);
  }

  Future savePin(String pin) async {
    return await _preferencesHelper.set(keyPin, pin);
  }

  void clearData() {
    _preferencesHelper.set(keyToken, emptyString);
    _preferencesHelper.set(keyPin, emptyString);
  }
}
