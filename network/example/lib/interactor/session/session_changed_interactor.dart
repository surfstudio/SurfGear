import 'package:name_generator/interactor/token/token_storage.dart';
import 'package:rxdart/subjects.dart';

/// Интерактор сессии пользователя
class SessionChangedInteractor {
  final AuthInfoStorage _ts;

  final PublishSubject<SessionState> sessionSubject = PublishSubject();

  SessionChangedInteractor(this._ts);

  void onSessionChanged() {
    sessionSubject.add(SessionState.LOGGED_IN);
  }

  void forceLogout() {
    sessionSubject.add(SessionState.LOGGED_OUT);
    _ts.clearData();
  }
}

enum SessionState { LOGGED_IN, LOGGED_OUT }
