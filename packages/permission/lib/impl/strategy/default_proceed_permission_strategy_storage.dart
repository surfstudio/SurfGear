import 'package:flutter/material.dart';
import 'package:permission/base/permission_manager.dart';
import 'package:permission/base/strategy/deny_resolve_strategy_storage.dart';
import 'package:permission/base/strategy/proceed_permission_strategy.dart';

/// Storage of proceed permission strategy.
class DefaultProceedPermissionStrategyStorage
    implements ProceedPermissionStrategyStorage {
  DefaultProceedPermissionStrategyStorage(
      {@required this.strategies, @required this.defaultStrategy})
      : assert(strategies != null);

  final Map<Permission, ProceedPermissionStrategy> strategies;
  final ProceedPermissionStrategy defaultStrategy;

  @override
  ProceedPermissionStrategy getStrategy(Permission permission) {
    if (!strategies.containsKey(permission)) return defaultStrategy;

    return strategies[permission];
  }
}
