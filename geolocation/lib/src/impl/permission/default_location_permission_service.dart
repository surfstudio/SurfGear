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
    return await _mapStatuses(await _permissionService.requestPermissions())
        .catchError(_handleError);
  }

  Future<PermissionStatus> _mapStatuses(lib.PermissionStatus status) async {
    switch (status) {
      case lib.PermissionStatus.unknown:
        return PermissionStatus.unknown;
        break;
      case lib.PermissionStatus.denied:
        bool shouldShowRationale =
            await _permissionService.shouldShowRequestPermissionRationale() ||
                Platform.isIOS;
        return shouldShowRationale
            ? PermissionStatus.should_show_rationale
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

  Future<PermissionStatus> _handleError(error, stacktrace) {
    if (error is PlatformException) {
      throw error;
    }

    return Future.value(PermissionStatus.denied);
  }
}
