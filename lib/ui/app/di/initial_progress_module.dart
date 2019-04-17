import 'package:injector/injector.dart';
import 'package:flutter_template/interactor/initial_progress/initial_progress_interactor.dart';
import 'package:flutter_template/interactor/initial_progress/storage/initial_progress_storage.dart';
import 'package:flutter_template/util/sp_helper.dart';

///Модуль для пробрасывания зависимостей к [InitialProgressInteractor]
class InitialProgressInteractorModule
    extends Module<InitialProgressInteractor> {
  InitialProgressInteractor _initialProgressInteractor;

  InitialProgressInteractorModule(PreferencesHelper helper) {
    _initialProgressInteractor = InitialProgressInteractor(
      InitialProgressStorage(helper),
    );
  }

  @override
  provides() => _initialProgressInteractor;
}
