import 'package:permission/base/permission_manager.dart';

/// Base class for proceed request permission.
abstract class ProceedPermissionStrategy {
  /// Method for proceed request permission.
  Future<void> proceed(Permission permission, PermissionStrategyStatus status);
}

/// Status of permission for proceed in strategy
enum PermissionStrategyStatus {
  /// User allow this permission
  allow,
  /// User deny this permission once or permanent deny not checked
  deny,
  /// User deny this permission with "Don't ask me" or deny on iOs
  permanent_deny
}