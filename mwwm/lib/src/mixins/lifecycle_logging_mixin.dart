import 'package:flutter/material.dart';
import 'package:mwwm/src/mixins/lifecycle_remote_logging_mixin.dart';

/// Mixin for logging widget [State] lifecycle.
///
/// That is basic implementation of [LifecycleLoggingMixin] which is able to log
/// widget state to console only. It got deprecated after
/// [LifecycleRemoteLoggingMixin] was released. Please, use
/// [LifecycleRemoteLoggingMixin] instead.
///
/// It's should not be used with [LifecycleRemoteLoggingMixin] at the same time
/// due to logs duplication issue.
@deprecated
mixin LifecycleLoggingMixin<T extends StatefulWidget> on State<T>{

  @override
  void initState() {
    super.initState();
    debugPrint("${this} initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("${this} didChangeDependencies");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("${this} dispose");
  }
}