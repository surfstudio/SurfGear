
import 'package:flutter_template/config/build_types.dart';

/// Конфигурация окружения
class Environment {
  final BuildType _currentBuildType;

  static Environment _instance;

  Environment._([this._currentBuildType = BuildType.debug]);

  static init({
    BuildType buildType,
  }) {
    _instance ??= Environment._(buildType);
  }

  factory Environment.instance() => _instance;

  bool get isDebug => _currentBuildType == BuildType.debug;
}
