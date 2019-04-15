import 'package:flutter_template/di/base/module.dart';
import 'package:flutter_template/interactor/session/session_changed_interactor.dart';
import 'package:flutter_template/interactor/token/token_storage.dart';

/// Модуль для интерактора [SessionChangedInteractor]
class SessionChangedModule extends Module<SessionChangedInteractor> {
  SessionChangedInteractor _interactor;

  SessionChangedModule(AuthInfoStorage ts) {
    _interactor = SessionChangedInteractor(ts);
  }

  @override
  SessionChangedInteractor provides() => _interactor;
}
