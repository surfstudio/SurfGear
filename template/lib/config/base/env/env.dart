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

import 'package:flutter_template/config/base/build_types.dart';
import 'package:meta/meta.dart';

/// Конфигурация окружения
class Environment<T> {
  final BuildType _currentBuildType;
  final T config;

  static Environment _instance;

  Environment._([BuildType buildType, this.config])
      : this._currentBuildType = buildType ?? BuildType.debug;

  static init<T>({
    @required BuildType buildType,
    @required T config,
  }) {
    _instance ??= Environment._(buildType, config);
  }

  factory Environment.instance() => _instance;

  bool get isDebug => _currentBuildType == BuildType.debug;
}
