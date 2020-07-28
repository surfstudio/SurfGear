import 'package:permission/base/permission_manager.dart';
import 'package:permission/base/strategy/proceed_permission_strategy.dart';

/// Storage of proceed permission strategy.
// ignore: one_member_abstracts
abstract class ProceedPermissionStrategyStorage {
  /// Return strategy of resolve deny permission.
  ProceedPermissionStrategy getStrategy(Permission permission);
}
