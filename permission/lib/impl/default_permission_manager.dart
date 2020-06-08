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

import 'dart:io';

import 'package:permission/base/exceptions.dart';
import 'package:permission/base/permission_manager.dart';
import 'package:permission/base/strategy/deny_resolve_strategy_storage.dart';
import 'package:permission/base/strategy/proceed_permission_strategy.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;

class DefaultPermissionManager implements PermissionManager {
  final ProceedPermissionStrategyStorage _strategyStorage;

  DefaultPermissionManager(this._strategyStorage);

  Future<bool> request(
    Permission permission, {
    bool checkRationale = false,
  }) async {
    final permissionGroup = _mapPermission(permission);
    final strategy = _strategyStorage.getStrategy(permission);

    final status = await permissionGroup.request();

    if (_isGoodStatus(status)) {
      await strategy?.proceed(permission, PermissionStrategyStatus.allow);
      return true;
    }

    if (checkRationale) {
      final showRationale = await permissionGroup.shouldShowRequestRationale;

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

  Future<bool> check(Permission permission) async {
    final status = await _mapPermission(permission).status;

    return _isGoodStatus(status);
  }

  Future<bool> openSettings() => permissionHandler.openAppSettings();

  bool _isGoodStatus(permissionHandler.PermissionStatus status) =>
      status == permissionHandler.PermissionStatus.granted ||
      status == permissionHandler.PermissionStatus.restricted;

  permissionHandler.Permission _mapPermission(Permission permission) {
    switch (permission) {
      case Permission.camera:
        return permissionHandler.Permission.camera;
      case Permission.gallery:
        return Platform.isAndroid
            ? permissionHandler.Permission.storage
            : permissionHandler.Permission.photos;
      case Permission.location:
        return permissionHandler.Permission.location;
      case Permission.calendar:
        return permissionHandler.Permission.calendar;
      case Permission.contacts:
        return permissionHandler.Permission.contacts;
      case Permission.microphone:
        return permissionHandler.Permission.microphone;
      case Permission.phone:
        return permissionHandler.Permission.phone;
      case Permission.speech:
        return permissionHandler.Permission.speech;
      case Permission.notification:
        return permissionHandler.Permission.notification;
      default:
        return permissionHandler.Permission.unknown;
    }
  }
}
