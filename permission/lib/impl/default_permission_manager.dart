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
import 'package:permission/impl/default_permission_handler.dart';
import 'package:permission/impl/notification_permission_handler.dart';
import 'package:permission_handler/permission_handler.dart' as lib;

class DefaultPermissionManager implements PermissionManager {
  final _permissionHandler = lib.PermissionHandler();
  final _handlers = [
    DefaultPermissionHandler(),
    NotificationPermissionHandler(),
  ];

  @override
  Future<bool> check(Permission permission) =>
      _findHandler(permission)?.check(permission);

  @override
  Future<bool> request(Permission permission, {bool checkRationale}) =>
      _findHandler(permission)?.request(
        permission,
        checkRationale: checkRationale,
      );

  PermissionHandler _findHandler(Permission permission) {
    return _handlers.firstWhere(
      (handler) => handler.canHandle(permission),
      orElse: () => null,
    );
  }

  Future<bool> openSettings() => _permissionHandler.openAppSettings();
}
