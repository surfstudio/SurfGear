import 'package:flutter_template/di/base/module.dart';

/// aka Dagger-component
/// Hold modules, that provide concrete dependencies
/// By 'get' terminal object able to receive dependency
abstract class Component {
  List<Module> getModules();

  T get<T>(Type t) => getModules()
      .where(
        (m) {
          print("DEV_INFO $m | ${m.provides()} | ${m.provides().runtimeType}");
          return m.provides().runtimeType == t;
        },
      )
      .first
      .provides();
}
