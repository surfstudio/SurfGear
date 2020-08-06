// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/foundation.dart';
import 'package:flutter_template/config/build_types.dart';

/// Конфигурация окружения
class Environment<T> implements Listenable {
  Environment._([BuildType buildType, T config])
      : _currentBuildType = buildType ?? BuildType.debug,
        _config = ValueNotifier(config);

  factory Environment.instance() => _instance as Environment<T>;

  final BuildType _currentBuildType;
  ValueNotifier<T> _config;

  T get config => _config.value;

  set config(T c) => _config.value = c;

  static Environment _instance;

  static void init<T>({
    @required BuildType buildType,
    @required T config,
  }) {
    _instance ??= Environment<T>._(buildType, config);
  }

  bool get isDebug => _currentBuildType == BuildType.debug;

  BuildType get buildType => _currentBuildType;

  @override
  void addListener(VoidCallback listener) {
    _config.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _config.removeListener(listener);
  }
}
