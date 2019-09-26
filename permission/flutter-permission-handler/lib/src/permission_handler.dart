import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/src/permission_enums.dart';
import 'package:permission_handler/src/utils/codec.dart';

/// Provides a cross-platform (iOS, Android) API to request and check permissions.
class PermissionHandler {
  factory PermissionHandler() {
    if (_instance == null) {
      const MethodChannel methodChannel =
          MethodChannel('flutter.baseflow.com/permissions/methods');

      _instance = PermissionHandler.private(methodChannel);
    }
    return _instance;
  }

  @visibleForTesting
  PermissionHandler.private(this._methodChannel);

  static PermissionHandler _instance;

  final MethodChannel _methodChannel;

  /// Check current permission status.
  ///
  /// Returns a [Future] containing the current permission status for the supplied [PermissionGroup].
  Future<PermissionStatus> checkPermissionStatus(
      PermissionGroup permission) async {
    final int status = await _methodChannel.invokeMethod(
        'checkPermissionStatus', permission.value);

    return Codec.decodePermissionStatus(status);
  }

  /// Check current service status.
  ///
  /// Returns a [Future] containing the current service status for the supplied [PermissionGroup].
  ///
  /// Notes about specific PermissionGroups:
  /// - **PermissionGroup.phone**
  ///   - Android:
  ///     - The method will return [ServiceStatus.notApplicable] when:
  ///       1. the device lacks the TELEPHONY feature
  ///       1. TelephonyManager.getPhoneType() returns PHONE_TYPE_NONE
  ///       1. when no Intents can be resolved to handle the `tel:` scheme
  ///     - The method will return [ServiceStatus.disabled] when:
  ///       1. the SIM card is missing
  ///   - iOS:
  ///     - The method will return [ServiceStatus.notApplicable] when:
  ///       1. the native code can not find a handler for the `tel:` scheme
  ///     - The method will return [ServiceStatus.disabled] when:
  ///       1. the mobile network code (MNC) is either 0 or 65535. See
  ///          https://stackoverflow.com/a/11595365 for details
  ///   - **PLEASE NOTE that this is still not a perfect indication** of the
  ///     devices' capability to place & connect phone calls
  ///     as it also depends on the network condition.
  Future<ServiceStatus> checkServiceStatus(PermissionGroup permission) async {
    final int status = await _methodChannel.invokeMethod(
        'checkServiceStatus', permission.value);

    return Codec.decodeServiceStatus(status);
  }

  /// Open the App settings page.
  ///
  /// Returns [true] if the app settings page could be opened, otherwise [false] is returned.
  Future<bool> openAppSettings() async {
    final bool hasOpened = await _methodChannel.invokeMethod('openAppSettings');

    return hasOpened;
  }

  /// Request the user for access to the supplied list of permissiongroups.
  ///
  /// Returns a [Map] containing the status per requested permissiongroup.
  Future<Map<PermissionGroup, PermissionStatus>> requestPermissions(
      List<PermissionGroup> permissions) async {
    final List<int> data = Codec.encodePermissionGroups(permissions);
    final Map<dynamic, dynamic> status =
        await _methodChannel.invokeMethod('requestPermissions', data);

    return Codec.decodePermissionRequestResult(Map<int, int>.from(status));
  }

  /// Request to see if you should show a rationale for requesting permission.
  ///
  /// This method is only implemented on Android, calling this on iOS always
  /// returns [false].
  Future<bool> shouldShowRequestPermissionRationale(
      PermissionGroup permission) async {
    if (!Platform.isAndroid) {
      return false;
    }

    final bool shouldShowRationale = await _methodChannel.invokeMethod(
        'shouldShowRequestPermissionRationale', permission.value);

    return shouldShowRationale;
  }
}
