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

import 'dart:io';

import 'package:permission/base/exceptions.dart';
import 'package:permission/base/permission_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class DefaultPermissionManager implements PermissionManager {
  final PermissionHandler _permissionHandler = PermissionHandler();

  Future<bool> request(
    Permission permission, {
    bool checkRationale = false,
  }) async {
    final permissionGroup = _mapPermission(permission);

    final statuses = await _permissionHandler.requestPermissions([
      permissionGroup,
    ]);

    final status = statuses[permissionGroup];
    if (_isGoodStatus(status)) return true;

    if (checkRationale) {
      final showRationale = await _permissionHandler
          .shouldShowRequestPermissionRationale(permissionGroup);

      if (showRationale) {
        return false;
      } else {
        throw FeatureProhibitedException();
      }
    }

    return false;
  }

  Future<bool> check(Permission permission) async {
    final status = await _permissionHandler.checkPermissionStatus(
      _mapPermission(permission),
    );

    return _isGoodStatus(status);
  }

  Future<bool> openSettings() => _permissionHandler.openAppSettings();

  bool _isGoodStatus(PermissionStatus status) =>
      status == PermissionStatus.granted ||
      status == PermissionStatus.restricted;

  PermissionGroup _mapPermission(Permission permission) {
    switch (permission) {
      case Permission.camera:
        return PermissionGroup.camera;
      case Permission.gallery:
        return Platform.isAndroid
            ? PermissionGroup.storage
            : PermissionGroup.photos;
      case Permission.location:
        return PermissionGroup.location;
      case Permission.calendar:
        return PermissionGroup.calendar;
      case Permission.contacts:
        return PermissionGroup.contacts;
      case Permission.microphone:
        return PermissionGroup.microphone;
      default:
        return PermissionGroup.unknown;
    }
  }
}
