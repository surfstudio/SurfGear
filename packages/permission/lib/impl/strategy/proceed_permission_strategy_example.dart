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

import 'package:permission/base/permission_manager.dart';
import 'package:permission/base/strategy/proceed_permission_strategy.dart';

/// Class with example strategy of proceed permission.
/// Do not use it! It's just example.
class ProceedPermissionStrategyExample implements ProceedPermissionStrategy {
  @override
  Future<void> proceed(
    Permission permission,
    PermissionStrategyStatus status,
  ) async {
    if (status == PermissionStrategyStatus.allow) {
      // ignore: avoid_print
      print('We have permission - $permission.');
    } else {
      // ignore: avoid_print
      print('Try get permission from user. $permission');
    }
  }
}
