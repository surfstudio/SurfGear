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

import 'package:flutter/services.dart';
import 'package:geolocation/src/base/permission/data/permission_status.dart';
import 'package:geolocation/src/base/permission/location_permission_service.dart';
import 'package:location_permissions/location_permissions.dart' as lib;

/// Default implementation of [LocationPermissionService]
/// todo
class DefaultLocationPermissionService implements LocationPermissionService {
  final lib.LocationPermissions _permissionService = lib.LocationPermissions();

  @override
  Future<PermissionStatus> checkPermissions() {
    return _permissionService
        .checkPermissionStatus()
        .then(_mapStatuses)
        .catchError(_handleError);
  }

  @override
  Future<bool> openAppSettings() {
    return _permissionService.openAppSettings();
  }

  @override
  Future<PermissionStatus> requestPermission() async {
    return _mapStatuses(await _permissionService.requestPermissions())
        .catchError(_handleError);
  }

  Future<PermissionStatus> _mapStatuses(lib.PermissionStatus status) async {
    switch (status) {
      case lib.PermissionStatus.unknown:
        return PermissionStatus.unknown;
        break;
      case lib.PermissionStatus.denied:
        final bool shouldShowRationale =
            await _permissionService.shouldShowRequestPermissionRationale() ||
                Platform.isIOS;
        return shouldShowRationale
            ? PermissionStatus.shouldShowRationale
            : PermissionStatus.denied;
        break;
      case lib.PermissionStatus.granted:
        return PermissionStatus.granted;
        break;
      case lib.PermissionStatus.restricted:
        return PermissionStatus.restricted;
      default:
        return PermissionStatus.unknown;
    }
  }

  Future<PermissionStatus> _handleError(Exception error, String stacktrace) {
    if (error is PlatformException) {
      throw error;
    }

    return Future.value(PermissionStatus.denied);
  }
}
