import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/auth/repository/auth_repository.dart';
import 'package:flutter_template/interactor/common/push/push_manager.dart';
import 'package:flutter_template/interactor/session/session_changed_interactor.dart';
import 'package:flutter_template/util/const.dart';
import 'package:rxdart/rxdart.dart';

///Интерактор для авторизации
class AuthInteractor {
  final AuthRepository _authRepository;
  final PushManager _pushManager;
  final SessionChangedInteractor _sessionChangedInteractor;

  Observable<bool> get isAuthorized => _authRepository.isAuthorized();

  Observable<bool> get hasPin => _authRepository.hasPin();

  AuthInteractor(
    this._authRepository,
    this._pushManager,
    this._sessionChangedInteractor,
  );

  ///проверка доступности авторизации
  ///
  ///@param phoneNumber - телефонный номер пользователя
  Observable<void> checkAccess(String phoneNumber) =>
      forceLogout().doOnDone(() => signIn(EMPTY_STRING, phoneNumber));

  ///авторизация
  ///
  ///@param otpCode - пришедший номер по смс
  ///@param phoneNumber - телефонный номер пользователя
  Observable<User> signIn(String otpCode, String phoneNumber) =>
      Observable(_pushManager.fcmTokenObservable.asStream())
          .flatMap(
            (token) => _authRepository.signIn(
                  otpCode,
                  AuthInfo(phone: phoneNumber, fcmToken: token),
                ),
          )
          .doOnData((_) => _sessionChangedInteractor.onSessionChanged);

  ///логаут
  Observable<void> logOut() => _authRepository
      .logOut()
      .doOnDone(() => _sessionChangedInteractor.forceLogout());

  Observable<void> forceLogout() =>
      Observable.just(_sessionChangedInteractor.forceLogout());

  /// Вход по пинкоду
  Observable<bool> checkPin(String pin) {
    return _authRepository.checkPin(pin);
  }

  /// Сохранение пинкода
  void savePinLocal(String pin) {
    _authRepository.savePin(pin);
  }

  Observable<bool> changePin(String oldPin, String newPin) {
    _authRepository.savePin(newPin);
    //эмуляция асинхронного запроса
    return Observable.just(true);
  }
}
