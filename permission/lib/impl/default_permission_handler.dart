import 'dart:io';

import 'package:permission/base/exceptions.dart';
import 'package:permission/base/permission_handler.dart';
import 'package:permission/base/permission_manager.dart';
import 'package:permission_handler/permission_handler.dart' as lib;

class DefaultPermissionHandler implements PermissionHandler {
  final _permissionHandler = lib.PermissionHandler();

  final _availableFeatures = [
    Permission.camera,
    Permission.gallery,
    Permission.location,
    Permission.calendar,
    Permission.contacts,
    Permission.microphone,
    Permission.phone,
  ];

  @override
  bool canHandle(Permission permission) =>
      _availableFeatures.contains(permission);

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

  bool _isGoodStatus(lib.PermissionStatus status) =>
      status == lib.PermissionStatus.granted ||
      status == lib.PermissionStatus.restricted;

  lib.PermissionGroup _mapPermission(Permission permission) {
    switch (permission) {
      case Permission.camera:
        return lib.PermissionGroup.camera;
      case Permission.gallery:
        return Platform.isAndroid
            ? lib.PermissionGroup.storage
            : lib.PermissionGroup.photos;
      case Permission.location:
        return lib.PermissionGroup.location;
      case Permission.calendar:
        return lib.PermissionGroup.calendar;
      case Permission.contacts:
        return lib.PermissionGroup.contacts;
      case Permission.microphone:
        return lib.PermissionGroup.microphone;
      case Permission.phone:
        return lib.PermissionGroup.phone;
      default:
        return lib.PermissionGroup.unknown;
    }
  }
}
