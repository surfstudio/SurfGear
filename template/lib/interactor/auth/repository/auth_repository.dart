import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/auth/repository/data/auth_request.dart';
import 'package:flutter_template/interactor/auth/repository/data/user_response.dart';
import 'package:flutter_template/interactor/token/token_storage.dart';
import 'package:flutter_template/util/const.dart';
import 'package:flutter_template/util/sp_helper.dart';
import 'package:network/network.dart';

const String KEY_PIN = "PIN";

///Репозиторий для авторизации
class AuthRepository {
  final RxHttp http;
  final AuthInfoStorage _tokenStorage;
  final PreferencesHelper _preferencesHelper;

  AuthRepository(
    this.http,
    this._preferencesHelper,
    this._tokenStorage,
  );

  ///авторизация
  ///
  ///@param otpCode - пришедший номер по смс
  ///@param info - информация необходимая для авторизации
  Future<User> signIn(String otpCode, AuthInfo info) {
    return http
        .post(
          EMPTY_STRING, //todo
          headers: otpCode.isNotEmpty ? {"X-OTP-Header": otpCode} : null,
          body: AuthRequest().from(info).toJson(),
        )
        .then((r) => UserResponse.fromJson(r.body))
        .then((ur) async {
      await _tokenStorage.saveToken(ur?.accessToken);
      return ur?.transform();
    });
  }

  ///логаут
  Future<void> logOut() {
    return http.post(
      EMPTY_STRING, //todo
    );
  }

  /// сохранение пин-кода локально
  /// todo шифрование пинкодом токена
  void savePin(String pin) {
    _tokenStorage.savePin(pin);
  }

  /// Проверка совпадения пинов
  Future<bool> checkPin(String pin) {
    return _tokenStorage.getPin().then((p) => p == pin);
  }

  /// Временно управляет авторизованностью пользователя
  Future<bool> isAuthorized() async {
    String token = await _tokenStorage.getAccessToken();

    return token != null && token.isNotEmpty;
  }

  /// Проверка наличия пина
  Future<bool> hasPin() async {
    String pin = await _tokenStorage.getPin();

    return pin.isNotEmpty;
  }
}
