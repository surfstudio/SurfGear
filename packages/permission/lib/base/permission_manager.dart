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
  phone, //only android
  speech, //only ios
  notification,
}

/// Service for requesting and checking permissions
abstract class PermissionManager {
  /// Permission request.
  /// Return true if granted.
  /// in case of "Don't ask me" and [checkRationale] throw
  /// FeatureProhibitedException
  /// (Actual for Android, on iOS always throw)
  Future<bool> request(Permission permission, {bool checkRationale});

  /// Check permission without dialog
  Future<bool> check(Permission permission);

  /// Open system settings.
  /// If user open settings return true
  Future<bool> openSettings();
}
