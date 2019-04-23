import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/auth/repository/data/auth_request.dart';
import 'package:flutter_template/interactor/auth/repository/data/user_response.dart';
import 'package:flutter_template/interactor/token/token_storage.dart';
import 'package:flutter_template/util/const.dart';
import 'package:network/network.dart';
import 'package:rxdart/rxdart.dart';

const String KEY_PIN = "PIN";

///Репозиторий для авторизации
class AuthRepository {
  final RxHttp http;
  final AuthInfoStorage _tokenStorage;

  AuthRepository(
    this.http,
    this._tokenStorage,
  );

  ///авторизация
  ///
  ///@param otpCode - пришедший номер по смс
  ///@param info - информация необходимая для авторизации
  Observable<User> signIn(String otpCode, AuthInfo info) {
    return http
        .post(
          EMPTY_STRING, //todo
          headers: otpCode.isNotEmpty ? {"X-OTP-Header": otpCode} : null,
          body: AuthRequest().from(info).toJson(),
        )
        .map((r) => UserResponse.fromJson(r.body))
        .map((ur) => ur.transform())
        .doOnData((ur) => _tokenStorage.saveToken(ur.accessToken));
  }

  ///логаут
  Observable<void> logOut() {
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
  Observable<bool> checkPin(String pin) {
    return _tokenStorage.getPin().then((p) => p == pin).asStream();
  }

  /// Временно управляет авторизованностью пользователя
  Observable<bool> isAuthorized() {
    return _tokenStorage
        .getAccessToken()
        .asStream()
        .map((token) => token != null && token.isNotEmpty);
  }

  /// Проверка наличия пина
  Observable<bool> hasPin() {
    return _tokenStorage.getPin().asStream().map((pin) => pin.isNotEmpty);
  }
}
