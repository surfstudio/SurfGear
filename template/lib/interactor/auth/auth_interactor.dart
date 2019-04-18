import 'dart:async';

import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/auth/repository/auth_repository.dart';
import 'package:flutter_template/interactor/common/push/push_manager.dart';
import 'package:flutter_template/interactor/session/session_changed_interactor.dart';
import 'package:flutter_template/util/const.dart';

///Интерактор для авторизации
class AuthInteractor {
  final AuthRepository _authRepository;
  final PushManager _pushManager;
  final SessionChangedInteractor _sessionChangedInteractor;

  Future<bool> get isAuthorized async => _authRepository.isAuthorized();

  Future<bool> get hasPin async => _authRepository.hasPin();

  AuthInteractor(
    this._authRepository,
    this._pushManager,
    this._sessionChangedInteractor,
  );

  ///проверка доступности авторизации
  ///
  ///@param phoneNumber - телефонный номер пользователя
  Future<void> checkAccess(String phoneNumber) =>
      forceLogout().then((_) => signIn(EMPTY_STRING, phoneNumber));

  ///авторизация
  ///
  ///@param otpCode - пришедший номер по смс
  ///@param phoneNumber - телефонный номер пользователя
  Future<User> signIn(String otpCode, String phoneNumber) =>
      _pushManager.fcmTokenObservable
          .then(
            (token) => _authRepository.signIn(
                  otpCode,
                  AuthInfo(phone: phoneNumber, fcmToken: token),
                ),
          )
          .whenComplete(_sessionChangedInteractor.onSessionChanged);

  ///логаут
  Future<void> logOut() => _authRepository.logOut().then((_) {
        _sessionChangedInteractor.forceLogout();
      });

  Future<void> forceLogout() async => _sessionChangedInteractor.forceLogout();

  /// Вход по пинкоду
  Future<bool> checkPin(String pin) {
    return _authRepository.checkPin(pin);
  }

  /// Сохранение пинкода
  void savePinLocal(String pin) {
    _authRepository.savePin(pin);
  }

  Future<bool> changePin(String oldPin, String newPin) {
    _authRepository.savePin(newPin);
    //эмуляция асинхронного запроса
    return Future(() => true);
  }
}
