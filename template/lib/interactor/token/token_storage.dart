import 'package:flutter_template/util/const.dart';
import 'package:flutter_template/util/sp_helper.dart';

/// Хранилище токена сессии
class AuthInfoStorage {
  AuthInfoStorage(this._preferencesHelper);

  static const keyToken = 'KEY_TOKEN';
  static const keyPin = 'KEY_PIN';

  final PreferencesHelper _preferencesHelper;
  String _token;

  Future<String> getAccessToken() async {
    _token = await _preferencesHelper.get(keyToken, emptyString).then((s) => s);
    return _token;
  }

  Future<String> getPin() async {
    final pin =
        await _preferencesHelper.get(keyPin, emptyString).then((s) => s);
    return pin;
  }

  Future saveToken(String token) async {
    return _preferencesHelper.set(keyToken, token);
  }

  Future savePin(String pin) async {
    return _preferencesHelper.set(keyPin, pin);
  }

  void clearData() {
    _preferencesHelper..set(keyToken, emptyString)..set(keyPin, emptyString);
  }
}
