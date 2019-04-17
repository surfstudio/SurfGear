import 'package:injector/injector.dart';
import 'package:flutter_template/interactor/token/token_storage.dart';
import 'package:flutter_template/util/sp_helper.dart';

///Модуль для пробрасывания зависимостей к [AuthInfoStorage]
class TokenStorageModule extends Module<AuthInfoStorage> {
  AuthInfoStorage _ts;

  TokenStorageModule(PreferencesHelper helper) {
    _ts = AuthInfoStorage(helper);
  }

  @override
  provides() => _ts;
}
