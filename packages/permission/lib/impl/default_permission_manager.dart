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
    as permission_handler;

class DefaultPermissionManager implements PermissionManager {
  DefaultPermissionManager(this._strategyStorage);

  final ProceedPermissionStrategyStorage _strategyStorage;

  @override
  Future<bool> request(
    Permission permission, {
    bool checkRationale = false,
  }) async {
    final permissionGroup = _mapPermission(permission);
    final strategy = _strategyStorage.getStrategy(permission);

    final status = await permissionGroup.request();

    if (_isGoodStatus(status)) {
      await strategy.proceed(permission, PermissionStrategyStatus.allow);
      return true;
    }

    if (checkRationale) {
      final showRationale = await permissionGroup.shouldShowRequestRationale;

      await strategy.proceed(
        permission,
        showRationale
            ? PermissionStrategyStatus.deny
            : PermissionStrategyStatus.permanentDeny,
      );

      if (showRationale) {
        return false;
      } else {
        throw FeatureProhibitedException();
      }
    }

    await strategy.proceed(permission, PermissionStrategyStatus.deny);
    return false;
  }

  @override
  Future<bool> check(Permission permission) async {
    final status = await _mapPermission(permission).status;

    return _isGoodStatus(status);
  }

  @override
  Future<bool> openSettings() => permission_handler.openAppSettings();

  bool _isGoodStatus(permission_handler.PermissionStatus status) =>
      status == permission_handler.PermissionStatus.granted ||
      status == permission_handler.PermissionStatus.restricted;

  permission_handler.Permission _mapPermission(Permission permission) {
    switch (permission) {
      case Permission.camera:
        return permission_handler.Permission.camera;
      case Permission.gallery:
        return Platform.isAndroid
            ? permission_handler.Permission.storage
            : permission_handler.Permission.photos;
      case Permission.location:
        return permission_handler.Permission.location;
      case Permission.calendar:
        return permission_handler.Permission.calendar;
      case Permission.contacts:
        return permission_handler.Permission.contacts;
      case Permission.microphone:
        return permission_handler.Permission.microphone;
      case Permission.phone:
        return permission_handler.Permission.phone;
      case Permission.speech:
        return permission_handler.Permission.speech;
      case Permission.notification:
        return permission_handler.Permission.notification;
      default:
        return permission_handler.Permission.unknown;
    }
  }
}
