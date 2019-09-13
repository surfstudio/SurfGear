import 'package:flutter_template/interactor/initial_progress/storage/initial_progress_storage.dart';

/// Интерактор для работы с прогрессом
/// todo здесь в итоге не проглдился, но в темплейт занесем
class InitialProgressInteractor {
  final InitialProgressStorage _storage;

  InitialProgressInteractor(this._storage);

  Future<InitialProgress> get _currentProgress async => _storage.getProgress();

  set progress(InitialProgress p) => _storage.setProgress(p);

  Future<bool> get isOnPinAuthStep async =>
      await _currentProgress == InitialProgress.pin_set;

  Future<bool> get isOnMain async =>
      await _currentProgress == InitialProgress.main;

  Future<bool> get isOnMac async =>
      await _currentProgress == InitialProgress.mac;
}
