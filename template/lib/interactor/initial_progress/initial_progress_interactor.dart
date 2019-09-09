/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

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
