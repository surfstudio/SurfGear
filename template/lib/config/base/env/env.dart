import 'package:flutter_template/config/base/build_types.dart';
import 'package:meta/meta.dart';

/// Конфигурация окружения
class Environment<T> {
  final BuildType _currentBuildType;
  final T config;

  static Environment _instance;

  Environment._([BuildType buildType, this.config])
      : this._currentBuildType = buildType ?? BuildType.debug;

  static init<T>({
    @required BuildType buildType,
    @required T config,
  }) {
    _instance ??= Environment._(buildType, config);
  }

  factory Environment.instance() => _instance;

  bool get isDebug => _currentBuildType == BuildType.debug;
}
