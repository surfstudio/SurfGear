import 'package:injector/injector.dart';
import 'package:flutter_template/interactor/auth/auth_interactor.dart';
import 'package:flutter_template/interactor/auth/repository/auth_repository.dart';
import 'package:flutter_template/interactor/common/push/push_manager.dart';
import 'package:flutter_template/interactor/session/session_changed_interactor.dart';
import 'package:flutter_template/interactor/token/token_storage.dart';
import 'package:flutter_template/util/sp_helper.dart';
import 'package:network/network.dart';

///Модуль для пробрасывания зависимостей к [AuthInteractor]
class AuthModule extends Module<AuthInteractor> {
  AuthInteractor _interactor;
  Http _http;
  PushManager _pushManager;

  AuthModule(
    this._http,
    this._pushManager,
    PreferencesHelper helper,
    AuthInfoStorage ts,
    SessionChangedInteractor _sc,
  ) {
    _interactor = AuthInteractor(
      AuthRepository(
        _http,
        helper,
        ts,
      ),
      _pushManager,
      _sc,
    );
  }

  @override
  provides() => _interactor;
}
