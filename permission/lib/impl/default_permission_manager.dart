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

import 'package:permission/base/permission_handler.dart';
import 'package:permission/base/permission_manager.dart';
import 'package:permission/base/strategy/deny_resolve_strategy_storage.dart';
import 'package:permission/base/strategy/proceed_permission_strategy.dart';
import 'package:permission_handler/permission_handler.dart';

class DefaultPermissionManager implements PermissionManager {
  final PermissionHandler _permissionHandler = PermissionHandler();
  final ProceedPermissionStrategyStorage _strategyStorage;

  DefaultPermissionManager(this._strategyStorage);

  Future<bool> request(
    Permission permission, {
    bool checkRationale = false,
  }) async {
    final permissionGroup = _mapPermission(permission);
    final strategy = _strategyStorage.getStrategy(permission);

    final statuses = await _permissionHandler.requestPermissions([
      permissionGroup,
    ]);

    final status = statuses[permissionGroup];
    if (_isGoodStatus(status)) {
      await strategy?.proceed(permission, PermissionStrategyStatus.allow);
      return true;
    }

    if (checkRationale) {
      final showRationale = await _permissionHandler
          .shouldShowRequestPermissionRationale(permissionGroup);

      await strategy?.proceed(
          permission,
          showRationale
              ? PermissionStrategyStatus.deny
              : PermissionStrategyStatus.permanent_deny);

      if (showRationale) {
        return false;
      } else {
        throw FeatureProhibitedException();
      }
    }

    await strategy?.proceed(permission, PermissionStrategyStatus.deny);
    return false;
  }

  PermissionHandler _findHandler(Permission permission) {
    return _handlers.firstWhere(
      (handler) => handler.canHandle(permission),
      orElse: () => null,
    );
  }

  Future<bool> openSettings() => _permissionHandler.openAppSettings();
}
