import 'package:flutter_template/util/sp_helper.dart';

const String _KEY_PROGRESS = "KEY_PROGRESS";

class InitialProgressStorage {
  final PreferencesHelper _preferencesHelper;

  InitialProgressStorage(this._preferencesHelper);

  Future<InitialProgress> getProgress() async {
    InitialProgress progress =
        await _preferencesHelper.get(_KEY_PROGRESS, 0).then((p) => _mapFrom(p));
    return progress;
  }

  Future<void> setProgress(InitialProgress progress) async {
    return await _preferencesHelper.set(_KEY_PROGRESS, progress.index);
  }

  InitialProgress _mapFrom(int ordinal) {
    switch (ordinal) {
      case 2:
        return InitialProgress.main;
      case 1:
        return InitialProgress.pin_set;
      case 0:
      default:
        return InitialProgress.auth;
    }
  }
}

enum InitialProgress { auth, pin_set, mac, main }
