import 'package:flutter/foundation.dart';
import 'package:flutter_template/config/build_types.dart';

/// Конфигурация окружения
class Environment<T> implements Listenable {
  final BuildType _currentBuildType;
  ValueNotifier<T> _config;

  T get config => _config.value;

  set config(T c) => _config.value = c;

  static Environment _instance;

  Environment._([BuildType buildType, T config])
      : this._currentBuildType = buildType ?? BuildType.debug,
        _config = ValueNotifier(config);

  static init<T>({
    @required BuildType buildType,
    @required T config,
  }) {
    _instance ??= Environment<T>._(buildType, config);
  }

  factory Environment.instance() => _instance;

  bool get isDebug => _currentBuildType == BuildType.debug;

  BuildType get buildType => _currentBuildType;

  @override
  void addListener(listener) {
    _config.addListener(listener);
  }

  @override
  void removeListener(listener) {
    _config.removeListener(listener);
  }
}
