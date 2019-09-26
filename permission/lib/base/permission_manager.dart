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

enum Permission {
  camera,
  gallery,
  location,
  calendar,
  contacts,
  microphone,
  phone,
  notifications,
}

/// Сервис запросов и проверки разрешений
abstract class PermissionManager {
  
  /// Запрос разрешения.
  /// Возвращает [true], если разрешение есть.
  /// Если [checkRationale], то выбросит [FeatureProhibitedException] в случае
  /// повторного отказа от использования фичи и последующего запрета.
  /// (Актуально только для Android, на iOS выбрасывается всегда.)
  Future<bool> request(Permission permission, {bool checkRationale});

  /// Проверка разрешения без запроса
  Future<bool> check(Permission permission);

  /// Открытие системных настроек.
  /// Возвращает [true], если экран с настройками был открыт.
  Future<bool> openSettings();
}
