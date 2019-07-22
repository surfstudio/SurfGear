import 'package:geolocation/src/base/permission/data/permission_status.dart';

/// Interface for work with location permissions
abstract class LocationPermissionService {

  Future<PermissionStatus> requestPermission();

  Future<bool> openAppSettings();

  Future<PermissionStatus> checkPermissions();

}