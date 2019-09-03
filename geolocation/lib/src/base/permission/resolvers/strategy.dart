import 'package:geolocation/src/base/permission/data/permission_status.dart';

/// Resolution strategy for permissions
abstract class ResolutionStrategy {
  Future resolve(PermissionStatus status);
}